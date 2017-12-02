CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    yaml_file = Rails.root.join("config", 'amazon_s3.yml').to_s

    if File.exists?(yaml_file)
      YAML.load_file(yaml_file)[Rails.env].each do |key, value|
        ENV[key.to_s] = value
      end # end YAML.load_file
    end
  end

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                'us-east-2'
  }
  config.fog_directory  = ENV['S3_BUCKET_NAME']
  config.cache_dir      = "#{Rails.root}/tmp/uploads"
end
