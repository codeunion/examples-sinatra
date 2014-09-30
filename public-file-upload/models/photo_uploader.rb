require "carrierwave/datamapper"

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # This is what we will use on a page with a list of photos
  version :thumb do
    process :resize_to_fill => [300, 300]
  end

  # This is what we will use on a photo's "show" page.
  version :full do
    process :resize_to_fit => [900, 900]
  end

  # This tells CarrierWave where to store the uploaded file. "model.id" will
  # cause CarrierWave to create one directory per photo uploaded, allowing
  # us to upload two files with the same filename.
  def store_dir
    "photos/#{model.id}/"
  end
end
