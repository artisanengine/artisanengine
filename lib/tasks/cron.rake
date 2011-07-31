desc "This task is called by the Heroku cron add-on."

task :cron => :environment do
  puts "Clearing new orders that have not been modified for 3 days ..."
    
  old_orders = Order.where( "orders.status = ? AND orders.updated_at > ?", 'new', 3.days.ago )
  count      = old_orders.count
    
  old_orders.destroy_all
  puts "#{ count } orders cleared."
  
  # -----
  
  puts "Marking orders that have been pending for more than 1 hour as abandoned ..."
  
  abandoned_orders = Order.where( "orders.status = ? AND orders.updated_at > ?", 'pending', 1.hour.ago )
  count            = abandoned_orders.count
  
  for order in abandoned_orders
    order.abandon!
  end
  
  puts "#{ count } orders abandoned."
end