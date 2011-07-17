module Manage
  class PatronsController < Manage::ManageController
    expose( :patrons ) { current_frame.patrons }
    expose( :patron )
  end
end