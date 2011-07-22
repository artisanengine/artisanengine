Dir[ "#{ Rails.root }/spec/support/factories/**/*.rb" ].each { |f| require f }
require 'factory_girl/syntax/generate'

namespace :db do
  desc "Fill database with demo data."
  
  task :demo => :environment do
    Rake::Task[ 'db:reset' ].invoke
    
    # Generate the super-user.
    Engineer.generate email: 'reade@artisanengine.dev', password: 'password'
    
    # ------------------------------------------------------------------
    # Frames
    
    hausleather   = Frame.generate name: 'Haus Leather',    domain: 'hausleather.dev'
    peggyskemp    = Frame.generate name: 'Peggy Skemp',     domain: 'peggyskemp.dev'
    emmysorganics = Frame.generate name: "Emmy's Organics", domain: 'emmysorganics.dev'
    zodiacleather = Frame.generate name: 'Zodiac Leather',  domain: 'zodiacleather.dev'
    
    # ------------------------------------------------------------------
    # Artisans
    
    Artisan.generate email: 'haus@hausleather.dev',    password: 'password', frame: hausleather
    Artisan.generate email: 'peggy@peggyskemp.dev',    password: 'password', frame: peggyskemp
    Artisan.generate email: 'ian@emmysorganics.dev',   password: 'password', frame: emmysorganics
    Artisan.generate email: 'reade@zodiacleather.dev', password: 'password', frame: zodiacleather
    
    # ------------------------------------------------------------------
    # Pages
    
    for frame in Frame.all
      5.times { Factory :loaded_page, frame: frame }
    end
    
    # ------------------------------------------------------------------
    # Images
    
    for frame in Frame.all
      5.times { Image.generate frame: frame }
    end
    
    # ------------------------------------------------------------------
    # Tags
    
    for frame in Frame.all
      5.times { Tag.generate frame: frame }
    end
    
    # ------------------------------------------------------------------
    # Posts
    
    for frame in Frame.all
      5.times { Factory :loaded_post, blog: frame.blog }
    end
    
    # Tag each post with a random number of tags.
    for post in Post.all
      post.tags = post.blog.frame.tags.sample( rand( 6 ) )
    end
    
    # ------------------------------------------------------------------
    # Goods, Options, and Variants
    
    for frame in Frame.all
      5.times { Good.generate frame: frame }
    end
    
    # Generate up to 5 options for each good.
    for good in Good.all
      rand( 6 ).times { good.options << Option.spawn( good: good ) }
    end
    
    # Generate up to 5 variants for each good.
    for good in Good.all
      rand( 6 ).times do
        # Determine how many options the good has, so we know how many random option values
        # to generate for the variant.
        num_options = good.options.count
        variant     = Variant.spawn good: good
      
        # Assign the variant with random values for each option.
        num_options.times do |time|
          eval( "variant.option_value_#{ time + 1 } = '#{ Faker::Lorem.words( 1 ).first }'" )
        end
      
        # Add the variant to the good.
        variant.save!
      end
    end
    
    # Attach up to 5 images to each good.
    for good in Good.all
      random_image_ids = []
      
      # Sample up to 5 random images from the frame.
      rand( 6 ).times do 
        random_image_ids << good.frame.images.sample.try( :id )
      end

      # Assign the images to the good. Only use unique IDs.
      good.image_ids = random_image_ids.uniq
    end
        
    # ------------------------------------------------------------------
    # Display Cases
    
    for frame in Frame.all
      3.times { DisplayCase.generate frame: frame }
    end
    
    # Assign up to 5 random goods to each display case.
    for display_case in DisplayCase.all
      random_good_ids = []
      
      # Sample up to 5 random goods from the frame.
      rand( 6 ).times do
        random_good_ids << display_case.frame.goods.sample.try( :id )
      end
      
      # Assign the goods to the display case. Only use unique IDs.
      display_case.good_ids = random_good_ids.uniq
    end
    
    # ------------------------------------------------------------------
    # Orders
    
    for frame in Frame.all
      3.times { Factory( :pending_order,   frame: frame ) }
      3.times { Factory( :purchased_order, frame: frame ) }
      3.times { Factory( :failed_order,    frame: frame ) }
    end
  end
end