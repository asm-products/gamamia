CarrierWave.configure do |config|

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :aws
    config.aws_acl = :public_read
    config.aws_credentials = {
      access_key_id:     Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key,
    }
    config.aws_bucket = Rails.application.secrets.aws_s3_bucket
  end

  # To let CarrierWave work on heroku
  config.cache_dir = Rails.root.join('tmp', 'uploads')
end
