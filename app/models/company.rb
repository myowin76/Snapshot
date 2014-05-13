class Company < ActiveRecord::Base
  attr_accessible :co_brand, :name, :logo


  has_attached_file :logo, 
  	:styles => {:normal => '210x65'},
  	:default_url => "/images/default_:style_company_logo.png",
  	:url  => "/assets/logos/:style/:basename.:extension",
    :path => "/assets/companies/logos/:basename.:extension",
    
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/aws.yml",
    :s3_permissions => {
      :default => :public_read,
    },
    :s3_protocol => 'http',
      :s3_options => {
        :server_side_encryption => 'AES256',
        :storage_class => :reduced_redundancy
      },
    :s3_headers => {"Content-Disposition" => "attachment"},
    :bucket => "SnapshotWorldWide"

    # validates_attachment_presence :logo
    validates_attachment_size :logo, :less_than => 5.megabytes
  	validates_attachment_content_type :logo, 
    
      :content_type => ['image/jpeg', 'image/pjpeg', 
  								   'image/jpg', 'image/png']
end