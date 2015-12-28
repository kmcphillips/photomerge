require "rubygems"
require "bundler/setup"

require "active_support/all"
require "fileutils"
require "mini_exiftool"
require "yaml"
require "pry"

Dir["./lib/*.rb"].each{ |f| require f }

class PhotoMergeError < StandardError ; end

camera_set = CameraSet.from_file("camera_set.yml")

binding.pry
