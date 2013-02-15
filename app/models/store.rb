class Store < ActiveRecord::Base
  attr_accessible :address, :address2, :address3, :town, :description, :latitude, :longitude, :name, 
  	:postcode, :retailer_id, :store_format_id, :country_id, :created_at, :updated_at, :location_id,
    :environment_type_id, :channel_id

  belongs_to :store_format
  belongs_to :retailer
  belongs_to :country
  has_many :audits
  has_many :photos, :through => :audits

  ## added after data structure changes
  belongs_to :environment_type
  belongs_to :channel

  
  # scope :by_retailer, lambda do |retailer|
  #   joins(:profile).where('profile.age = ?', age) unless age.nil?
  # end  
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Store exist."}
  # validates :postcode, :uniqueness => {:message => "Store exist."}

  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  # GEOCODERS
  acts_as_gmappable :process_geocoding => false

  # scope :by_postcode, lambda{|postcode| where('postcode LIKE ?', "%#{postcode}%") unless postcode.blank? }    
  # validates :postcode, :presence => true, :uniqueness => true

  # scope :in_countries, lambda{ |c_ids| where('country_id IN (?)', c_ids) }

  def country_name(id)
    Country.find_by_id(id).name unless id.nil?
  end
  
  def full_address
    [address, address2, address3, town, postcode, country_name(country_id)].compact.join(', ')
  end
  
  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << column_names
  #     all.each do |store|
  #       csv << store.attributes.values_at(*column_names)
  #     end
  #   end
  # end

  def self.to_csv(store_ids, options = {})
    CSV.generate(options) do |csv|
      column_names = ['Name' ,'address', 'Format']
      csv << column_names
      store_ids.each do |store_id|
        store = Store.find_by_id(store_id)
        csv << [store.name, store.address, store.address2] 
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
