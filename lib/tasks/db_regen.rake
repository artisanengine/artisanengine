namespace :db do
  desc "Regenerate the schema and databases."
  
  task :regen => :environment do
    # Drop all databases and remove the schema.
    puts "Dropping all databases ..."
    Rake::Task[ 'db:drop:all' ].invoke

    puts "Dropping schema ..."
    File.delete( "#{ Rails.root }/db/schema.rb" )
    
    # Generate the new schema and prepare the test database.
    puts "Regenerating databases ..."
    Rake::Task[ 'db:migrate' ].invoke
    
    puts "Preparing test database ..."
    Rake::Task[ 'db:test:prepare' ].invoke
    
    puts "Regenerated!"
  end
end