# require 'open-uri'
class Photo < ActiveRecord::Base
  
  
  belongs_to :audit
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :brandings
  has_many :brands, :through => :brandings
  has_many :medialocations
  has_many :media_locations, :through => :medialocations
  has_many :mediavehicles
  has_many :media_vehicles, :through => :mediavehicles
  has_many :promotiontypes
  has_many :promotion_types, :through => :promotiontypes
  has_many :mediatypes
  has_many :media_types, :through => :mediatypes
  has_many :themings
  has_many :themes, :through => :themings
  belongs_to :promotion_calendar
  #belongs_to :theme
  
  attr_accessible :description, :created_at, :audit_id, 
      :theme_ids, :brand_compliant, :display_for_project, :insight, :role_of_comm, :perspective,
      :additional_brands, :photo_file_name, :data_complete,
  		:promotion_calendar_id, :published, :headline, :photo, 
      :category_ids, :brand_ids, :media_location_ids, :media_vehicle_ids, :media_type_ids, :promotion_type_ids
      
    
  has_attached_file :photo, 
  	:styles => { :large => "640x480", :medium => "300x300>", :small => "100x100>" },
    # :url  => "/audits/:id/:style/:basename.:extension",
  	 # :path => ":rails_root/public/audits/:id/:styles/:basename.:extension",
    :path => 'photos/photos/000/000/:id/:style/:basename.:extension',
    # :storage => :filesystem,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/aws.yml",
    :s3_permissions => {
      :thumbnail => :public_read,
      :small => :public_read,
      :medium => :public_read,
      :large => :public_read,
      :original => :private
    },
    :s3_protocol => 'http',
      :s3_options => {
        :server_side_encryption => 'AES256',
        :storage_class => :reduced_redundancy,
        :content_disposition => 'attachment'
      },
    :s3_headers => {"Content-Disposition" => "attachment"},
    :bucket => "SnapshotWorldWide"
		
    validates_attachment_presence :photo

  	validates_attachment_content_type :photo, 
    #validates_attachment_size :photo, :less_than => 5.megabytes
      :content_type => ['image/jpeg', 'image/pjpeg', 
  								   'image/jpg', 'image/png']

    acts_as_gmappable :process_geocoding => false
    # def gmaps4rails_infowindow
    #   # add here whatever html content you desire, it will be displayed when users clicks on the marker
    #   # "<h4>#{self.title}</h4>"
    #   "<h4>Title</h4>"
    # end

    scope :order_date_desc, order("created_at DESC")
    scope :published, where(published: true)
    scope :unpublished, where(published: false)
    scope :all_brand_compliant, where(brand_compliant: true)

    
    

    def self.find_between fromdate, todate
      where(:created_at => fromdate .. todate)
    end

    # def self.generate_csv(photo_ids, options = {})
    def self.generate_csv()
      
      CSV.generate() do |csv|
        column_names = ['Filename', 'Date', 'Headline', 'Sector', 'Retailer', 'Category','Store', 'Address','Country', 'Promotion Calendar', 
              'Promotion Type', 'Media Location', 'Media Type', 'Media Vehicle', 'Theme', 'Brand', 'Additional Brands', 'Description']
        csv << column_names
        
        ['3795','3810'].each do |photo_id|
          photo = Photo.find_by_id(photo_id)
          
          @country = photo.audit.store.country.name unless photo.audit.store.country_id.nil?
          @promo_cal = photo.promotion_calendar.name unless photo.promotion_calendar_id.nil?
          @promo_type = photo.promotion_types.map(&:name).join(",") unless photo.promotion_types.nil?
          @media_loc = photo.media_locations.map(&:name).join(",") unless photo.media_locations.nil?
          @media_types = photo.media_types.map(&:name).join(",") unless photo.media_types.nil?
          @media_veh = photo.media_vehicles.map(&:name).join(",") unless photo.media_vehicles.nil?
          @media_themes = photo.themes.map(&:name).join(",") unless photo.themes.nil?
          @media_brands = photo.brands.map(&:name).join(",") unless photo.brands.nil?

          csv << [
                  photo.photo_file_name, photo.created_at, photo.headline, 
                  photo.audit.store.retailer.sector.name,
                  photo.audit.store.retailer.name, 
                  photo_category_names(photo),
                  photo.audit.store.name,
                  photo.audit.store.address,
                  photo.audit.store.address2,
                  @country,
                  @promo_cal,
                  @promo_type,
                  @media_loc,
                  @media_types,
                  @media_veh,
                  @media_themes,
                  @media_brands,
                  photo.additional_brands,
                  photo.description
                ]
        end
        send_file csv, :type => 'text/csv'
      end
    end

    def self.zip_all_from_store store
      
      assets = store.photos

      zip_file = Tempfile.new("#{Rails.root}/public/" << store.name.to_s << ".zip")
      Zip::ZipOutputStream.open(zip_file) do |zos|
        assets.each do |asset|
          
          download_url = open(URI.parse(URI.encode(asset.photo.url(:large))))
          # csv_file = open(csv)
          zos.put_next_entry(asset.photo_file_name)
          zos.print IO.read(download_url)
          
        end
        # debugger
        # zos.put_next_entry("data.csv")
        # zos.print IO.read(csv_file)
      end
      zip_file
      
    end

    def self.zip_files photo_ids
      # NEED TO GENERATE CSV FILE WITH RELATED IMAGES INFORMATION 
      # AND ALSO ADDED TO ZIP FILE
      # CSV.generate(options) do |csv|
      #   photo_ids.each do |photo_id|
      #     column_names = ['Headline','  Sector', 'Retailer', 'Category','Store', 'Date', 'Address','Country', 'Promotion Calendar', 
      #         'Promotion Type', 'Media Location', 'Media Type', 'Media Vehicle', 'Theme', 'Brand', 'Additional Brands', 'Description']
      #     csv << column_names

      #   end
      # end

      assets = find_all_by_id(photo_ids)
      # csv = generate_csv(photo_ids)

      zip_file = Tempfile.new("#{Rails.root}/public/" << "export".to_s << ".zip")
      Zip::ZipOutputStream.open(zip_file) do |zos|
        assets.each do |photo_id|
          asset = find_by_id(photo_id)
          download_url = open(URI.parse(URI.encode(asset.photo.url(:large))))
          # csv_file = open(csv)
          zos.put_next_entry(asset.photo_file_name)
          zos.print IO.read(download_url)
          
        end
        # debugger
        # zos.put_next_entry("data.csv")
        # zos.print IO.read(csv_file)
      end
      zip_file
    end
    
    scope :by_audits_in_stores, lambda { |stores, environment, channel|
      includes(:audit).where('audits.store_id IN (?) AND audits.environment_type_id IN (?) AND audits.channel_id IN (?)',
         stores, environment, channel) }

    private
    def self.photo_category_names(photo)
      photo.categories.map(&:name).join(",") unless photo.categories.nil?
    end  
end
