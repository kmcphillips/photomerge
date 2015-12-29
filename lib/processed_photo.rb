class ProcessedPhoto < Photo

  def date=(new_date)
    exif.date_time_original = new_date
    exif.create_date = new_date

    exif.save
  end

end
