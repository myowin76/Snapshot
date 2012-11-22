class Store < ActiveRecord::Base
  attr_accessible :address, :address2, :description, :latitude, :longitude, :name, 
  	:postcode, :retailer_id, :store_format_id, :country_id

  belongs_to :store_format
  belongs_to :retailer
  belongs_to :country
  belongs_to :location
  has_many :audits
  

  # geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  # GEOCODERS
  acts_as_gmappable :process_geocoding => false

  # scope :by_postcode, lambda{|postcode| where('postcode LIKE ?', "%#{postcode}%") unless postcode.blank? }    
  validates :postcode, :presence => true, :uniqueness => true

  def full_address
    [address, address2, postcode].join(',')
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |store|
        csv << store.attributes.values_at(*column_names)
      end
    end
  end
  
  private

   #Get full address from longitude and latitude
   def area_address
     address=GoogleGeocoder.reverse_geocode([self.latitude,self.longitude])
     address.full_address
   end

end
