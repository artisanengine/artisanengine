desc "Clean up tempfiles, clear logs, and regenerate databases."
task :regen do
  puts "Dropping all databases ..."
  Rake::Task[ 'db:drop:all' ].invoke

  puts "Dropping schema ..."
  schema = "#{ Rails.root }/db/schema.rb"
  File.delete( schema ) if File.exists?( schema )

  puts "Cleaning up image files ..."
  dragonfly_images = "#{ Rails.root }/public/system/dragonfly"
  FileUtils.rm_r( dragonfly_images ) if File.exists?( dragonfly_images )

  puts "Regenerating databases ..."
  Rake::Task[ 'db:migrate' ].invoke

  puts "Preparing test database ..."
  Rake::Task[ 'db:test:prepare' ].invoke
  
  puts "Seeding development database ..."
  system( 'rake db:demo RAILS_ENV=development' )
  
  puts "Clearing logs ..."
  Rake::Task[ 'log:clear' ]
  
  puts "Clearing temp files ..."
  Rake::Task[ 'tmp:clear' ]

  puts "I feel clean and pretty!"
end