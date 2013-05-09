class Setting < ActiveRecord::Base
  attr_accessible :setting, :value

  def self.check_db_updates
    # @last_update_country = Country.order("updated_at").last.updated_at
    @last_update_store = Store.order("updated_at").last.updated_at
    @last_update_category = Category.order("updated_at").last.updated_at
    @last_update_brand = Brand.order("updated_at").last.updated_at
    @last_update_sector = Sector.order("updated_at").last.updated_at
    @last_update_retailer = Retailer.order("updated_at").last.updated_at    
    @settings = Setting.find(1)
    # unless @settings.nil?
      
    # else
    #   @settings = Setting.create!
    # end  
    @settings.update_attribute(:db_update_store, @last_update_store)
    @settings.update_attribute(:db_update_category, @last_update_category)
    @settings.update_attribute(:db_update_brand, @last_update_brand)
    @settings.update_attribute(:db_update_sector, @last_update_sector)
    @settings.update_attribute(:db_update_retailer, @last_update_retailer)
    

  end
end
