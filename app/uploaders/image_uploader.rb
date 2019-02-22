class ImageUploader < CarrierWave::Uploader::Base


  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
