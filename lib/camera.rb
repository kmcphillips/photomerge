class Camera
  attr_reader :name, :folder, :suffix, :photos, :identity_photo

  def initialize(path, name: nil, suffix: nil, identity_photo: nil)
    @folder = CameraSet.validated_folder(path)
    @name = name.presence || @folder.path.split("/").last
    @suffix = suffix.presence || @name

    load_photos

    if identity_photo.present?
      @identity_photo = @photos.find{|photo| photo.path.path.ends_with?("/#{ identity_photo }") }
      raise PhotoMergeError, "identity photo #{ identity_photo } could not be found" unless @identity_photo
    end
  end

  def inspect
    "#<Camera #{ name } with #{ @photos.count } photos, suffix: #{ suffix }, path: #{ folder.path }, identity_photo: #{ @identity_photo.try(:path) }>"
  end

  private

  def load_photos
    puts "Loading camera #{ name }"

    @photos = Dir.glob("#{ folder.path }/*.{JPG,jpg}").map do |path|
      Photo.new(path, camera: self)
    end

    puts "\nDone with #{ @photos.count } photos"

    @photos
  end
end
