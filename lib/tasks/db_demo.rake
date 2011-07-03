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
    Page.generate title: 'About', content: "About Emmy's",    frame: emmysorganics

    # ------------------------------------------------------------------
    # Images
    
    5.times { Image.generate frame: hausleather }
    5.times { Image.generate frame: peggyskemp }
    5.times { Image.generate frame: emmysorganics }
    
    # ------------------------------------------------------------------
    # Tags
    
    5.times { Tag.generate frame: hausleather }
    5.times { Tag.generate frame: peggyskemp }
    5.times { Tag.generate frame: emmysorganics }
    
    # ------------------------------------------------------------------
    # Posts
    
    5.times { Post.generate blog: hausleather.blog }
    5.times { Post.generate blog: peggyskemp.blog }
    5.times { Post.generate blog: emmysorganics.blog }
    
    # Tag each post with a random number of tags.
    for post in Post.all
      post.tags = post.blog.frame.tags.sample( rand( 6 ) )
    end
    
    # ------------------------------------------------------------------
    # Goods, Options, and Variants
    
    5.times { Good.generate frame: hausleather }
    5.times { Good.generate frame: peggyskemp }
    5.times { Good.generate frame: emmysorganics }
    
    # Generate up to 5 options for each good.
    for good in Good.all
      rand( 6 ).times { good.options << Option.spawn }
    end
    
    # Generate up to 5 variants for each good.
    for good in Good.all
      rand( 6 ).times do
        # Determine how many options the good has, so we know how many random option values
        # to generate for the variant.
        num_options = good.options.count
        variant     = Variant.spawn
      
        # Assign the variant with random values for each option.
        num_options.times do |time|
          eval( "variant.option_value_#{ time + 1 } = '#{ Faker::Lorem.words( 1 ).first }'" )
        end
      
        # Add the variant to the good.
        good.variants << variant
      end
    end
  end
end