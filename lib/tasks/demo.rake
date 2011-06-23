namespace :db do
  desc "Fill database with demo data."
  
  task :demo => :environment do
    puts "Resetting database ..."
    Rake::Task[ 'db:reset' ].invoke
    
    puts "Filling database with demo data ..."    
    
    # ------------------------------------------------------------------
    # Frames
    
    Fabricate :frame, name:   'Haus Leather',
                      domain: 'hausleather'
    
    Fabricate :frame, name:   'Peggy Skemp Jewelry',
                      domain: 'peggyskemp'
  
    puts "Demo database filled!"
  end
end