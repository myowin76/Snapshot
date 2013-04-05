class	PhotoPdf < Prawn::Document

	def initialize(photo)
    
    super(:page_layout => :landscape, :page_size => "A4", :margin => [20,30])
		@photo = photo
		
    define_grid(:columns => 6, :rows => 8, :gutter => 10)
    
    grid([0,3], [7,0]).bounding_box do
      move_down 10
      pad_bottom(18) { text "#{@photo.audit.store.name.upcase}", :size => 16, :style => :bold }
      stroke_horizontal_rule
      move_down 10
      photo_image
    end
    
    grid([0,5],[7,4]).bounding_box do
      logo  
      show_data
    end
	end

  def show_data
    
    font_size 10
    if @photo.audit.store
      store_details @photo
    end
    
    move_down 10
    photo_details @photo

  end

	def logo

		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.png"), :width => 200, :position => :right
		move_down(10)
	end
	
	def photo_image

    dimensions = Paperclip::Geometry.from_file("#{@photo.photo.url(:large)}")
    
    if(dimensions.width > dimensions.height)
		  image open("#{@photo.photo.url(:large)}"), :width => 518	
    else
      
      image open("#{@photo.photo.url(:large)}"), :height => 480  
    end  
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	end
  
  def store_details photo

      data = [[ "", ""]]
      data += [[ "STORE", ""]]
      data += [[ "Retailer","#{photo.audit.store.retailer.name}"]]
      data += [[ "Retail Sector","#{photo.audit.store.retailer.sector.name}"]]
      data += [[ "Store Name","#{photo.audit.store.name}"]]
      address = ""
      if photo.audit.store.address.present?
        address = "Address: #{photo.audit.store.address}, "
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
      data += [[ "Address", address]]
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
        # :row_colors => ["f9f9f9", "f9f9f9"], 
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
    if photo.categories.present?
        data += [[ "Categories","#{photo.categories.map(&:name).join(", ")}"]]
      end
      if photo.brands
          data += [[ "Brands", "#{photo.brands.map(&:name).join(", ")}"]]
      end
      if photo.promotion_calendar_id.present?
        data += [[ "Promotion Calendar", "#{photo.promotion_calendar.name}"]]
      end  
      if photo.promotion_types
          promotion_types = 
          data += [[ "Promotion Types", "#{photo.promotion_types.map(&:name).join(", ")}"]]
      end
      if photo.media_locations
        data += [[ "Promotion Types", "#{photo.media_locations.map(&:name).join(", ")}"]]
      end
      if photo.media_types
        data += [[ "Media Types", "#{photo.media_types.map(&:name).join(", ")}"]]
      end   
      if photo.media_vehicles
        data += [[ "Media Types", "#{photo.media_vehicles.map(&:name).join(", ")}"]]
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