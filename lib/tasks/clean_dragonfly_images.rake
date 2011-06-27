namespace :dragonfly do
  desc "Clean Dragonfly images created during testing."
  
  task :clean => :environment do
    puts "Cleaning up Dragonfly images ..."
    FileUtils.rm_r( "#{ Rails.root }/public/system/dragonfly/test" )
  end
end