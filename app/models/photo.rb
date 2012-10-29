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

  attr_accessible :description, :created_at, :audit_id, :brand_id, :category_id, :media_location_id, 
  		:media_vehicle_id, :media_type_id, :promotion_calendar_id, :promotion_type_id, :theme_id, :photo

  has_attached_file :photo, 
  	:styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
    #:url  => "/audits/:id/:style/:basename.:extension",
  	#:path => ":rails_root/public/audits/:id/:styles/:basename.:extension",
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
    :bucket => "SnapshotWorldWide"
		
    validates_attachment_presence :photo
  	validates_attachment_content_type :photo, 
    #validates_attachment_size :photo, :less_than => 5.megabytes
      :content_type => ['image/jpeg', 'image/pjpeg', 
  								   'image/jpg', 'image/png']

     #def photo_attributes=(photo_attributes)
   	 #photo_attributes.each do |attributes|
     #photos.build(attributes)
     #end
     #end  

    acts_as_gmappable :process_geocoding => false

  	
    

    #def self.destroy_pics(store, photos)
  	#	Photo.find(photos, :conditions => {:hotel_id => hotel}).each(&:destroy)
  	#end
    def find_photos
      find(:all, :conditions => conditions)
    end
    

    #def self.search(search)
    #  if search
        #find_by_postcode()
        
        #find(:all, :conditions => ['category_id IN (?)', "category[]"])
    #    find(:all, :conditions => ['created_at > (?)', Date.parse("%#{search}%")])

        
    #  else
    #    find(:all)
    #  end
    #end

    private #------------------------------
    
    def date_filter_conditions
      #['created_at between (?)and (?)', 
      #    Date.parse(params[:search][:fromDate]), Date.parse(params[:search][:toDate])]
    end
    def promotion_cal_conditions
      ["promotion_calendar_id = ?", promo_cal] unless promo_cal.blank?
    end
    def promotion_type_conditions
      ["promotion_type_id = ?", promo_type] unless promo_type.blank?
    end
    def media_vehicle_conditions
      #["media_vehicle_id = ?", promo_type] unless promo_type.blank?
    end
    def media_location_conditions
      #["media_location_id = ?", media_loc] unless media_loc.blank?
    end
    def media_type_conditions
      #["media_type_id = ?", promo_type] unless promo_type.blank?
    end
    def postcode_conditions
      
    end
    def location_conditions
      
    end
    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end

    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end

    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end

    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end


end
