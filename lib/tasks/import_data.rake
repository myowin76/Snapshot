namespace :data do
  task :image_process => :environment do
		# @photos = Photo.all
		# @content = "Aldi Aylesbury 31.5.12-002"
		# @contents = ["Currys","Aldi Aylesbury 31.5.12-002"]
		# @contents = Dir.entries(File.join(Rails.root, 'bin', 'test'))

		Dir.glob(File.join(Rails.root, 'bin', 'test', '*')) do |content|

			# photo = Photo.new
			# photo.photo = File.open(content)
			# photo.save!
			# open(content) do |f|
   #      photo = Photo.new(:photo_file_name => File.basename(content),
   #                         :photo => f)
   #      # a side affect of saving is that paperclip transformation will
   #      # happen
   #      photo.save!
   #    end
			File.open(content) do |f|
				photo = Photo.new
	      photo.photo = f # just assign the logo attribute to a file
	      photo.save
	    end #file gets closed automatically here
		end
		# @contents = Dir.entries(File.join(Rails.root, 'bin'))
		# if File.directory?(content)
		# else
		#	end
		# @photos.each do |photo|
		# 	@contents.each do |content|
		# 		content = content.gsub(/[\s]+/, '_')
		# 		if (content.to_s == photo.photo_file_name.to_s)
		# 			# path
		# 			# process that Image and put in the defined path
		# 			# puts content
		# 			 puts photo.id
		# 		end
		# 	end
		# end	
		# Dir.glob(File.join(Rails.root,'bin')).each do |content|
		# 	puts content
		# end

		# Dir.glob(File.join(Rails.root, 'bin')).entries.each do |e|
		#   photo = Model.find(...)        
		#   model.attachment = File.open(e)
		#   modle.save
		# end
	
  end
end