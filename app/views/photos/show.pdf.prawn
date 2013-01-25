pdf.text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
pdf.move_down(30)

pdf.text "Category: #{@photo.category.name}", :size => 12
pdf.text "Brand: #{@photo.brand.name}", :size => 12
pdf.text "Store: #{@photo.audit.store.name}", :size => 12
pdf.text "Retailer: #{@photo.audit.retailer.name}", :size => 12


pdf.image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
pdf.text "Promotion Calendar: #{@photo.promotion_calendar.name}"
pdf.text "Promotion Type: #{@photo.promotion_type.name}"
pdf.text "Media Location: #{@photo.media_location.name}"
pdf.text "Media Type: #{@photo.media_type.name}"
pdf.text "Retail Sector: #{@photo.audit.store.retailer.sector.name}"
pdf.text "Environment Type: #{@photo.audit.environment_type.name}"
pdf.text "Media Vehicle: #{@photo.media_vehicle.name}"
pdf.text "Country: #{@photo.audit.store.country.name}"
pdf.text "Store Format: #{@photo.audit.store.store_format.name}"

pdf.move_down(10)
