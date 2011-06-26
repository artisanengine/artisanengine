Dir[ "#{ Rails.root }/spec/support/factories/**/*.rb" ].each { |f| require f }

namespace :db do
  desc "Fill database with demo data."
  
  task :demo => :environment do
    puts "Resetting database ..."
    Rake::Task[ 'db:reset' ].invoke
    
    puts "Filling database with demo data ..."    
    
    # ------------------------------------------------------------------
    # Frames
    
    hausleather = Factory :frame, name:   'Haus Leather',
                                  domain: 'hausleather.dev'
    
    peggyskemp  = Factory :frame, name:   'Peggy Skemp Jewelry',
                                  domain: 'peggyskemp.dev'
  
    # ------------------------------------------------------------------
    # Users
    
    Factory :engineer, email:                 'reade@artisanengine.dev',
                       password:              'micagrl',
                       password_confirmation: 'micagrl',
                       frame:                 hausleather
 
    Factory :artisan, email:                 'haus@hausleather.dev',
                      password:              'password',
                      password_confirmation: 'password',
                      frame:                 hausleather
    
    Factory :artisan, email:                 'peggy@peggyskemp.dev',
                      password:              'password',
                      password_confirmation: 'password',
                      frame:                 peggyskemp

    # ------------------------------------------------------------------
    # Pages
    
    # Create an About page for Haus Leather.
    Factory :page, frame: hausleather, title: 'About', content: 'About Haus.'
    
    # Create a Bio page for Peggy Skemp.
    Factory :page, frame: peggyskemp, title: 'Bio', content: 'Peggy Skemp Bio.'
  
    puts "Demo database filled!"
  end
end