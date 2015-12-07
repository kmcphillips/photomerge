class Camera
  attr_reader :name, :folder

  def initialize(path, name: nil)
    if File.exists?(path)
      @folder = File.new(path)
      raise PhotoMergeError, "Path #{ path } is not a directory" unless File.directory?(@folder)
    else
      raise PhotoMergeError, "Path #{ path } does not exist"
    end

    @name = name.presence || @folder.path
  end


end
