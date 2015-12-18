require "rubygems"
require "bundler/setup"

require "active_support/all"
require "fileutils"
require "exifr"
require "pry"

Dir["./lib/*.rb"].each{ |f| require f }

class PhotoMergeError < StandardError ; end

output = "/home/kevin/Desktop/Brocember/output"

cameras = [
  Camera.new(
    "/home/kevin/Desktop/Brocember/kevin",
    output: output,
    name: "kevin",
    suffix: "km",
  ),

  Camera.new(
    "/home/kevin/Desktop/Brocember/patrick",
    output: output,
    name: "patrick",
    suffix: "ph",
  ),

  Camera.new(
    "/home/kevin/Desktop/Brocember/eliot",
    output: output,
    name: "eliot",
    suffix: "eb",
  ),
]

binding.pry
