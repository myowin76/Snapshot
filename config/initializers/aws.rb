# load the libraries
require 'aws'
# log requests using the default rails logger
AWS.config(:logger => Rails.logger)
# load credentials from a file
config_path = File.expand_path(File.dirname(__FILE__)+"/../amazon_s3.yml")
AWS.config(YAML.load(File.read(config_path)))