CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAIMWY3T4I2A3GCJ6Q',
    aws_secret_access_key: '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',
    region: 'us-east-1'
  }

  config.fog_directory = 'design-s3-image'
  config.fog_public = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end