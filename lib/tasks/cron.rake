desc "This task is called by the Heroku cron add-on."

task :cron => :environment do
  puts "Clearing new orders that have not been modified for 3 days ..."
    
  abandoned_orders = Order.where( "orders.status = ? AND orders.updated_at < ?", 'new', 3.days.ago )
  count            = abandoned_orders.count
    
  abandoned_orders.destroy_all
  puts "#{ count } orders cleared."
end