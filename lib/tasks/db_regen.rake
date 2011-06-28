namespace :db do
  desc "Regenerate the schema and databases."
  
  task :regen => :environment do
    # Drop all databases and remove the schema.
    puts "Dropping all databases ..."
    Rake::Task[ 'db:drop:all' ].invoke

    puts "Dropping schema ..."
    schema = "#{ Rails.root }/db/schema.rb"
    File.delete( schema ) if File.exists?( schema )
    
    puts "Cleaning up image files ..."
    dragonfly_images = "#{ Rails.root }/public/system/dragonfly/development"
    FileUtils.rm_r( dragonfly_images ) if File.exists?( dragonfly_images )
    
    # Generate the new schema and prepare the test database.
    puts "Regenerating databases ..."
    Rake::Task[ 'db:migrate' ].invoke
    
    puts "Preparing test database ..."
    Rake::Task[ 'db:test:prepare' ].invoke
    
    puts "Regenerated!"
  end
end