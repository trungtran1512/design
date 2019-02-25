CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAJQQ2SFVLAOUNMNEA',
      aws_secret_access_key: '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',
      region: 'us-west-2'
    }
    config.storage = :fog
    config.fog_directory = 'design-image'
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end