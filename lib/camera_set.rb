class CameraSet
  attr_accessor :cameras, :output, :sequence, :identity_photo_expected_time, :processed_photos

  def initialize(output: nil, identity_photo_expected_time: nil)
    @cameras = []
    @sequence = 1
    @identity_photo_expected_time = identity_photo_expected_time
    @processed_photos = []

    if output.present?
      @output = CameraSet.validated_folder(output)
    else
      @output = CameraSet.validated_folder(File.join(path, "output"))
    end
  end

  def photos
    cameras.map(&:photos).flatten.sort{|x,y| x.date_with_offset <=> y.date_with_offset }
  end

  def process
    puts "Processing #{ photos.count } photos from #{ cameras.count } cameras"

    photos.each do |photo|
      destination_path = File.join(output.path, photo.filename(@sequence))

      FileUtils.cp(photo.path.path, destination_path)

      processed_photo = ProcessedPhoto.new(destination_path, camera: photo.camera)
      processed_photo.date = photo.date_with_offset
      processed_photos << processed_photo

      @sequence = @sequence + 1
      print "."
    end

    puts "\nDone"
  end

  class << self

    def from_file(filename)
      config = YAML.load_file(filename)

      set = self.new(output: config["output"], identity_photo_expected_time: Time.new(*config["identity_photo_expected_time"]))

      config["cameras"].each do |camera_config|
        camera = Camera.new(
          camera_config["input"],
          name: camera_config["name"],
          suffix: camera_config["suffix"],
          identity_photo: camera_config["identity_photo"],
        )

        camera.identity_photo_offset = set.identity_photo_expected_time - camera.identity_photo.date

        set.cameras << camera
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
