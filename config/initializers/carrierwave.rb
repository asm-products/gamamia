CarrierWave.configure do |config|

  # For testing, upload files to local `tmp` folder.
 if Rails.env.test? || Rails.env.development?
   config.storage = :file
   config.enable_processing = false
 else
   config.storage = :aws

   config.aws_credentials = {
     access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
     secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
   }
   config.aws_bucket = ENV.fetch('AWS_S3_BUCKET')
 end

 # To let CarrierWave work on heroku
 config.cache_dir = Rails.root.join('tmp', 'uploads')
end
