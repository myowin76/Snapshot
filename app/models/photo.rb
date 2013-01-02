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
    scope :published, where(published: true)
    scope :unpublished, where(published: false)

    def self.find_between fromdate, todate
      where(:created_at => fromdate .. todate)
    end


    def self.generate_csv(photo_ids, options = {})
      CSV.generate(options) do |csv|
        column_names = ['Headline','  Sector', 'Retailer', 'Category','Store', 'Date', 'Address','Country', 'Promotion Calendar', 
              'Promotion Type', 'Media Location', 'Media Type', 'Media Vehicle', 'Theme', 'Brand', 'Additional Brands', 'Description']
        csv << column_names
        
        photo_ids.each do |photo_id|
          photo = Photo.find_by_id(photo_id)
          csv << [photo.headline]
          
        end
      end
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

      zip_file = Tempfile.new("#{Rails.root}/public/" << "export".to_s << ".zip")
      Zip::ZipOutputStream.open(zip_file) do |zos|
        photo_ids.each do |photo_id|
          asset = find_by_id(photo_id)
          download_url = open(URI.parse(URI.encode(asset.photo.url(:large))))

          zos.put_next_entry(asset.photo_file_name)
          zos.print IO.read(download_url)
        end
      end
      zip_file
    end
    
    scope :by_audits_in_stores, lambda { |stores, environment, channel|
      includes(:audit).where('audits.store_id IN (?) AND audits.environment_type_id IN (?) AND audits.channel_id IN (?)',
         stores, environment, channel) }


end
