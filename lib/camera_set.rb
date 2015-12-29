class CameraSet
  attr_accessor :cameras, :output, :sequence

  def initialize(output: nil)
    @cameras = []
    @sequence = 1

    if output.present?
      @output = CameraSet.validated_folder(output)
    else
      @output = CameraSet.validated_folder(File.join(path, "output"))
    end
  end

  def photos
    cameras.map(&:photos).flatten.sort{|x,y| x.date <=> y.date }
  end

  def process
    photos.each do |photo|
      # FileUtils.cp(photo.path.path, File.join(output.path, photo.fileanme(sequence)))
      puts "Copy #{photo.path.path} to #{File.join(output.path, photo.filename(sequence))}"
    end
  end

  class << self

    def from_file(filename)
      config = YAML.load_file(filename)

      set = self.new(output: config["output"])

      config["cameras"].each do |camera_config|
        set.cameras << Camera.new(
          camera_config["input"],
          name: camera_config["name"],
          suffix: camera_config["suffix"],
          identity_photo: camera_config["identity_photo"],
        )
      end

      set
    end

    def validated_folder(path)
      if File.exists?(path)
        folder = File.new(path)
        raise PhotoMergeError, "Path #{ path } is not a directory" unless File.directory?(folder)
      else
        raise PhotoMergeError, "Path #{ path } does not exist"
      end

      folder
    end

  end
end
