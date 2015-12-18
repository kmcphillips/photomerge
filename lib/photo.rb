class Photo
  attr_reader :path, :camera

  def initialize(path, camera:)
    @path = File.new(path)
    @camera = camera

    load_photo
  end

  def inspect
    "#<Photo path: #{ path.path }, camera: #{ camera.inspect }>"
  end

  private

  def load_photo

  end
end
