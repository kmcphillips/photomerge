class Photo
  attr_reader :path, :camera, :exif

  def initialize(path, camera:)
    @path = File.new(path)
    @camera = camera

    load_photo
  end

  def date
    exif.date_time
  end

  def inspect
    "#<Photo path: #{ path.path }, camera: #{ camera.inspect }, exif: { date_time: #{ date }>"
  end

  private

  def load_photo
    print "."

    @exif = EXIFR::JPEG.new(path.path)
  end
end
