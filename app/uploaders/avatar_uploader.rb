class AvatarUploader < CarrierWave::Uploader::Base

  storage :fog

  def store_dir
     "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
