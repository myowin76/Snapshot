class Store < ActiveRecord::Base
  attr_accessible :address, :address2, :description, :latitude, :longitude, :name, 
  	:postcode, :retailer_id, :store_format_id, :country_id

  belongs_to :store_format
  belongs_to :retailer
  belongs_to :country
  has_many :audits
  geocoded_by :postcode
  after_validation :geocode
  
  scope :by_postcode, lambda{|postcode| where('postcode LIKE ?', "%#{postcode}%") unless postcode.blank? }    

  # GEOCODERS
  acts_as_gmappable :process_geocoding => false

  def full_address
    [address, address2].join(' ')
  end
  
  private

   #Get full address from longitude and latitude
   def area_address
     address=GoogleGeocoder.reverse_geocode([self.latitude,self.longitude])
     address.full_address
   end

end
