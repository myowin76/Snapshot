# include Geokit::Geocoders
class Store < ActiveRecord::Base
  attr_accessible :address, :address2, :description, :latitude, :longitude, :name, 
  	:postcode, :retailer_id, :store_format_id

  belongs_to :store_format
  belongs_to :retailer
  has_many :audits


  #gmap4rails
  acts_as_gmappable



  # GEOKITS
  #acts_as_mappable :default_units => :miles,
	#	:default_formula => :sphere,
#		:distance_field_name => :distance,
	#	:lat_column_name => :latitude,
	#	:lng_column_name => :longitude

	#	before_save :generate_longitude_latitude    
    # before_save :generate_longitude_latitude_from_address

    def full_address
      [address, address2].join(' ')
    end

    def self.search(search)
      if search
        find(:all, :conditions => ['postcode LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end



    private

    def generate_longitude_latitude
      if !self.postcode.blank?
        #Geocode the postcode
        geocode = MultiGeocoder.geocode(self.postcode)
        self.latitude = geocode.ll.split(",")[0]
        self.longitude = geocode.ll.split(",")[1]
      else
        #Geocode the address
        geocode = MultiGeocoder.geocode(full_address)
        self.latitude = geocode.ll.split(",")[0]
        self.longitude = geocode.ll.split(",")[1]
      end
    end

    def generate_longitude_latitude_from_address
      #Geocode the postcode
      geocode = MultiGeocoder.geocode(full_address)
      self.latitude = geocode.ll.split(",")[0]
      self.longitude = geocode.ll.split(",")[1]
    end


   #Get full address from longitude and latitude
   def area_address
     address=GoogleGeocoder.reverse_geocode([self.latitude,self.longitude])
     address.full_address
   end

end
