class CameraSet
  attr_accessor :cameras

  def initialize
    @cameras = []
  end

  def photos
    cameras.map(&:photos).flatten.sort{|x,y| x.date <=> y.date }
  end

  class << self

    def from_file(filename)
      config = YAML.load_file(filename)

      set = self.new

      config["cameras"].each do |camera_config|
        set.cameras << Camera.new(
          camera_config["input"],
          output: camera_config["output"],
          name: camera_config["name"],
          suffix: camera_config["suffix"],
        )
      end

      set
    end

  end

end
