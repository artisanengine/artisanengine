Dir[ "#{ Rails.root }/spec/support/factories/**/*.rb" ].each { |f| require f }
require 'factory_girl/syntax/generate'

namespace :db do
  desc "Fill database with demo data."
  
  task :demo => :environment do
    Rake::Task[ 'db:reset' ].invoke
    
    # Generate the super-user.
    Engineer.generate email: 'reade@artisanengine.dev', password: 'micagrl'
    
    # ------------------------------------------------------------------
    # Frames
    
    hausleather   = Frame.generate name: 'Haus Leather',    domain: 'hausleather.dev'
    peggyskemp    = Frame.generate name: 'Peggy Skemp',     domain: 'peggyskemp.dev'
    emmysorganics = Frame.generate name: "Emmy's Organics", domain: 'emmysorganics.dev'
  
    # ------------------------------------------------------------------
    # Artisans
    
    Artisan.generate email: 'haus@hausleather.dev',  password: 'password', frame: hausleather
    Artisan.generate email: 'peggy@peggyskemp.dev',  password: 'password', frame: peggyskemp
    Artisan.generate email: 'ian@emmysorganics.dev', password: 'password', frame: emmysorganics

    # ------------------------------------------------------------------
    # Pages
    
    Page.generate title: 'About', content: 'About Haus',      frame: hausleather
    Page.generate title: 'Bio',   content: 'Peggy Skemp Bio', frame: peggyskemp 

    # ------------------------------------------------------------------
    # Images
    
    5.times { Image.generate frame: hausleather }
    5.times { Image.generate frame: peggyskemp }
  end
end