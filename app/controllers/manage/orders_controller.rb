module Manage
  class OrdersController < Manage::ManageController
    expose( :orders ) { current_frame.orders }
  end
end