class Photo < ActiveRecord::Base
  
  belongs_to :brand
  belongs_to :audit
  belongs_to :category
  belongs_to :media_location
  belongs_to :media_vehicle
  belongs_to :media_type
  belongs_to :promotion_type
  belongs_to :promotion_calendar

  attr_accessible :description, :audit_id, :brand_id, :category_id, :media_location_id, 
  		:media_vehicle_id, :media_type_id, :promotion_calendar_id, :promotion_type_id, :photo

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
  	def gmaps4rails_infowindow
      "<img src=\"#{self.photo_file_name}\"> #{self.photo_file_name}"
    end
    def gmaps4rails_title
      "<h3>title</h3>"
    end


    def self.destroy_pics(hotel, photos)
  		Photo.find(photos, :conditions => {:hotel_id => hotel}).each(&:destroy)
  	end

    def self.search(search)
      if search
        find(:all, :conditions => ['postcode LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end

    



end
