require 'rubygems'
require 'bundler'

Bundler.require(:default)
Rack::Utils.multipart_part_limit = 2000 # upload limit

require_all 'app'
run Simplepics