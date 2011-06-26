# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create an Example frame and an engineer user, or no one gets to have any fun.
frame = Frame.create! domain: 'example.com',
                      name:   'Example Frame'

reade = User.new first_name:            'Reade',
                 last_name:             'Harris',
                 email:                 'reade@artisanengine.com',
                 password:              'micagrl',
                 password_confirmation: 'micagrl'
reade.role  = 'Engineer'
reade.frame = frame
reade.save!