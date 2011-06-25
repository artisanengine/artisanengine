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
    # Pages
    
    # Create an About page for Haus Leather.
    Factory :page, frame: hausleather, title: 'About', content: 'About Haus.'
    
    # Create a Bio page for Peggy Skemp.
    Factory :page, frame: peggyskemp, title: 'Bio', content: 'Peggy Skemp Bio.'
  
    puts "Demo database filled!"
  end
end