S3DirectUpload.config do |c|
  c.access_key_id = Rails.application.secrets.s3_access_key_id    # your access key id
  c.secret_access_key = Rails.application.secrets.s3_secret_access_key   # your secret access key
  c.bucket = Rails.application.secrets.s3_bucket             # your bucket name
  #c.region = nil             # region prefix of your bucket url. This is _required_ for the non-default AWS region, eg. "s3-eu-west-1"
  c.url = "https://#{c.bucket}.s3.amazonaws.com/"                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end
