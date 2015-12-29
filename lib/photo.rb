class Photo
  attr_reader :path, :camera, :exif

  def initialize(path, camera:)
    @path = File.new(path)
    @camera = camera

    load_photo
  end

  def date
    exif.create_date
  end

  def date=(new_date)
    exif.date_time_original = new_date
    exif.create_date = new_date

    exif.save
  end

  def filename(sequence)
    sections = ["IMG", "%04d" % sequence, camera.suffix]
    "#{ sections.join("_") }.jpg"
  end

  def inspect
    "#<Photo path: #{ path.path }, camera: #{ camera.inspect }, exif: { date_time: #{ date }>"
  end

  private

  def load_photo
    print "."
    @exif = MiniExiftool.new(path.path)
  end
end
