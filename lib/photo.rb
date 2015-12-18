class Photo
  attr_reader :path, :camera, :exif

  def initialize(path, camera:)
    @path = File.new(path)
    @camera = camera

    load_photo
  end

  def inspect
    "#<Photo path: #{ path.path }, camera: #{ camera.inspect }, exif: { date_time: #{ exif.date_time }>"
  end

  private

  def load_photo
    @exif = EXIFR::JPEG.new(path.path)
  end
end
