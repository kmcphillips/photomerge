class Camera
  attr_reader :name, :folder, :suffix, :output

  def initialize(path, name: nil, suffix: nil, output: nil)
    @folder = validated_folder(path)

    if output.present?
      @output = validated_folder(output)
    else
      @output = validated_folder(File.join(path, "output"))
    end

    @name = name.presence || @folder.path.split("/").last
    @suffix = suffix.presence || @name

    load_photos
  end

  def inspect
    "#<Camera #{ name } with #{ @photos.count } photos, suffix: #{ suffix }, path: #{ folder }, output: #{ output }>"
  end

  private

  def load_photos
    @photos = Dir.glob("#{ folder.path }/*.{JPG,jpg}").map do |path|
      Photo.new(path, camera: self)
    end
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
