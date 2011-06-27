require 'dragonfly'

app = Dragonfly[ :images ]

app.configure_with :image_magick
app.configure_with :rails

app.define_macro( ActiveRecord::Base, :image_accessor )

app.configure do |config|
  config.protect_from_dos_attacks = true
  config.secret                   = '1mag!3is7i(al'
end