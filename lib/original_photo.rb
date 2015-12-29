class OriginalPhoto < Photo

  def filename(sequence)
    sections = ["IMG", "%04d" % sequence, camera.suffix]
    "#{ sections.join("_") }.jpg"
  end

end
