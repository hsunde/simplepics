require 'rubygems'
require 'bundler'

Bundler.require(:default)

# require 'sinatra/base'
# require 'sequel'
# require "json"
# require "digest/md5"
# require "pp"
# require "fileutils"
# require "securerandom"
# require 'bcrypt'
# require 'require_all'
# require 'shotgun'
# require 'mimemagic'
# require 'digest/bubblebabble'
# require 'securerandom'

# require "sinatra/reloader"
# require "sinatra/content_for"

# require 'uri'
# require 'open-uri'

Rack::Utils.multipart_part_limit = 2000 # upload limit

# app_dir = File.expand_path("../..", __FILE__)
# shared_dir = "#{app_dir}/shared"
# bind "unix://#{shared_dir}/sockets/puma.sock"







require_all 'app'
# require_relative 'app/controllers/simple.rb'

run Simplepics