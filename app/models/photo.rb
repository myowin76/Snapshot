class Photo < ActiveRecord::Base
  
  belongs_to :brand
  belongs_to :audit
  belongs_to :category
  belongs_to :media_location
  belongs_to :media_vehicle
  belongs_to :media_type
  belongs_to :promotion_type
  belongs_to :promotion_calendar
  belongs_to :theme
  
  attr_accessible :description, :created_at, :audit_id, :brand_id, :category_id, :media_location_id,  :additional_brands, :photo_file_name,
  		:media_vehicle_id, :media_type_id, :promotion_calendar_id, :promotion_type_id, :theme_id, :published, :headline, :photo

  has_attached_file :photo, 
  	:styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
    # :url  => "/audits/:id/:style/:basename.:extension",
  	# :path => ":rails_root/public/audits/:id/:styles/:basename.:extension",

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

    scope :published, lambda { where("published = ?", true) }
    # scope :published, lambda { where("published = ?", true) }
    # named_scope :by_category, lambda do |category_id|
    #   joins(:category).where('category.id IN (?)', cat) unless category_id.nil?
    # end
    # def find_photos
    #   find(:all, :conditions => conditions)
    # end

    def category_tokens=(ids)
      # self.category_id = Category.ids_from_tokens(tokens)
      self.category_id = ids.split(",")
      
    end
    def published?
      published == 1
    end
    
    def category_array(ids)
      self.category_ids = ids.split(",")
    end
    
    def self.search_by(params)
      find(:all, :conditions => conditions ) 
      
    end
    
    private

    def self.find_photos
      photos = Photo.all  
    end
    
    def category_conditions
      ["category_id IN ?", params[:search][:category]] unless search[:category].blank?
      
    end
    def self.date_filter_conditions
      # ['photos.created_at >= (?) AND photos.created_at <= (?)', 
      #     Date.parse(options[:fromDate]), Date.parse(options[:toDate])]
    end
    
    def self.promotion_cal_conditions
      #["promotion_calendar_id = ?", promo_cal] unless promo_cal.blank?
    end
    
    def self.promotion_type_conditions
      #["promotion_type_id = ?", promo_type] unless promo_type.blank?
    end
    
    def self.media_vehicle_conditions
      #["media_vehicle_id = ?", promo_type] unless promo_type.blank?
    end
    
    def self.media_location_conditions
      #["media_location_id = ?", media_loc] unless media_loc.blank?
    end
    
    def self.media_type_conditions
      #["media_type_id = ?", promo_type] unless promo_type.blank?
    end
    
    def self.conditions

      [conditions_clauses.join(' AND '), *conditions_options]
      debugger
    end

    def self.conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end

    def self.conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end

    def self.conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
      debugger
    end


end
