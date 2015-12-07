require "rubygems"
require "bundler/setup"
require "fileutils"
require "pry"

Dir["./lib/*.rb"].each{ |f| require f }

class PhotoMergeError < StandardError ; end

