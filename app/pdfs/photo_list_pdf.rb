
class	PhotoListPdf < Prawn::Document
	def initialize(photos)
		
		# super(:page_layout => :landscape, :page_size => "A4", :margin => [60,40])
    super(:page_layout => :landscape, :page_size => "A4", :margin => [20,30])
		font "Helvetica", :size => 10
		
		photo_ids = photos.split(",")
		@photo_list = Photo.find_all_by_id(photo_ids)
		move_up 30
    repeat(:all) do
		  header
    end  
		move_down 30

    photo_rows

	end

	def header
    move_down(30)
	end
	
	def logo
		# image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
    image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.png"), :width => 200, :position => :right
    move_down(10)
	end

  def photo_rows
    # debugger
    @photo_list.map do |photo|
      define_grid(:columns => 6, :rows => 8, :gutter => 10)

      grid([0,3], [7,0]).bounding_box do

        move_down 10
        pad_bottom(18) { text "#{photo.audit.store.name.upcase}", :size => 16, :style => :bold }
        stroke_horizontal_rule
        move_down 10
          bounding_box([0, cursor], :width => 518, :height => 480) do
            photo_image photo
          end
        end

      grid([0,5],[7,4]).bounding_box do
        logo
        # if photo.audit.store
          store_details photo
        # end
        move_down 10
        photo_details photo  

      end
      start_new_page unless photo == @photo_list.last
    end
  end

  def photo_image photo
    
      image open("#{photo.photo.url(:original)}"), :fit => [518, 480], :position => :center
    
	end
  
  
  def store_details photo
    
    data = [[ "", ""]]
    data += [[ "STORE", ""]]
    data += [[ "Retailer","#{photo.audit.store.retailer.name}"]]
    data += [[ "Retail Sector","#{photo.audit.store.retailer.sector.name}"]]
    data += [[ "Store Name","#{photo.audit.store.name}"]]
    address = ""
    if photo.audit.store.address.present?
      address = "#{photo.audit.store.address}, "
    end
    if photo.audit.store.address2.present?
      address = address +"#{photo.audit.store.address2}, "
    end
    if photo.audit.store.address3.present?
      address = address + "#{photo.audit.store.address3}, "
    end
    unless photo.audit.store.town.nil?
      if photo.audit.store.town.present?
        address = address + "#{photo.audit.store.town}, "
      end
    end  
    if photo.audit.store.postcode.present?
      address = address + "#{photo.audit.store.postcode}"
    end
    data += [[ "Address", address]] if photo.audit.store.address.present?
    unless photo.audit.store.country_id.nil?
      data += [[ "Country", "#{photo.audit.store.country.name}" ]]
    end
    
    data += [[ "Store Format", "#{photo.audit.store.store_format.name}" ]]
    data += [[ "Environment Type:", "#{photo.audit.store.environment_type.name}" ]]
    
    if photo.audit.store.channel.present?
      data += [[ "Channel","#{photo.audit.store.channel.name}"]]
    end 

    data += [[ "", ""]]
      
      table(data) do
        cells.padding = [4,12]
        cells.borders = []
        cells.background_color = "EEEEEE"
        row(1).font_style = :bold
        cells.columns(0).width = 100
        cells.columns(1).width = 150
        
      end
  
  end

  def photo_details photo
      
      data = [[ "", ""]]
      data += [[ "IMAGE DATA", ""]]
      data +=[["Audit Date", "#{photo.audit.audit_date}"]]
      if photo.brands.present?
          data += [[ "Brands", "#{photo.brands.map(&:name).join(", ")}"]]
          if photo.brands.first.brand_owner_id.present?
            owners = BrandOwner.find_all_by_id(photo.brands.map(&:brand_owner_id)).map(&:name).join(", ")
            data += [["Brand Owners", "#{owners}"]]
          end
      end
      
      if photo.categories.present?
        data += [[ "Categories","#{photo.categories.map(&:name).join(", ")}"]]
      end
      if photo.promotion_calendar_id.present?
        data += [[ "Promotion Calendar", "#{photo.promotion_calendar.name}"]]
      end  
      if photo.promotion_types.present?
        data += [[ "Promotion Types", "#{photo.promotion_types.map(&:name).join(", ")}"]]
      end
      if photo.media_locations.present?
        data += [[ "Media Locations", "#{photo.media_locations.map(&:name).join(", ")}"]]
      end
      if photo.media_types.present?
        data += [[ "Media Types", "#{photo.media_types.map(&:name).join(", ")}"]]
      end   
      if photo.media_vehicles.present?
        data += [[ "Media Vehicles", "#{photo.media_vehicles.map(&:name).join(", ")}"]]
      end 
      data += [[ "", ""]]

      table(data) do
        cells.padding = [4,12]
        cells.borders = []
        cells.background_color = "EEEEEE"
        row(1).font_style = :bold
        cells.columns(0).width = 100
        cells.columns(1).width = 150
        
      end
  end

    

end