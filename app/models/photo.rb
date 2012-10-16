class Photo < ActiveRecord::Base
  belongs_to :brand
  belongs_to :audit
  belongs_to :category
  belongs_to :media_location
  belongs_to :media_vehicle
  belongs_to :media_type

  attr_accessible :description, :audit_id, :brand_id, :category_id, :media_location_id, 
  		:media_vehicle_id, :media_type_id, :photo

  has_attached_file :photo, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" }
	#validates_attachment_presence :uploaded_file
    #	validates_attachment_content_type :uploaded_file, 
    #	:content_type => ['image/jpeg', 'image/pjpeg', 
    #								   'image/jpg', 'image/png']





end
