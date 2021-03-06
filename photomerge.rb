require "rubygems"
require "bundler/setup"

require "active_support/all"
require "fileutils"
require "mini_exiftool"
require "yaml"
require "pry"

require Dir["./lib/photo.rb"].first
Dir["./lib/*.rb"].each{ |f| require f }

class PhotoMergeError < StandardError ; end

set = CameraSet.from_file("camera_set.yml")
set.process
