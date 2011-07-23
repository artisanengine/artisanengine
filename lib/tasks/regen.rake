desc "Clean up tempfiles and clear logs."
task :shed do
  puts "Cleaning up image files ..."
  dragonfly_images = "#{ Rails.root }/public/system/dragonfly"
  FileUtils.rm_r( dragonfly_images ) if File.exists?( dragonfly_images )
  
  puts "Clearing logs ..."
  Rake::Task[ 'log:clear' ]
  
  puts "Clearing temp files ..."
  Rake::Task[ 'tmp:clear' ]

  puts "I feel clean and pretty!"
end