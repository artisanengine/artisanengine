require 'dragonfly'

app = Dragonfly[ :images ]

app.configure_with :image_magick
app.configure_with :rails
app.configure_with :heroku, ENV[ "S3_BUCKET" ] unless Rails.env.test? or Rails.env.development?

app.define_macro( ActiveRecord::Base, :image_accessor )

app.configure do |config|
  config.protect_from_dos_attacks = true
  config.secret                   = '1mag!3is7i(al'
end