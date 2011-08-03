require 'csv'

module Manage
  class PatronsController < Manage::ManageController    
    expose( :patrons ) { current_frame.patrons }
    expose( :patron )
    
    def index
      respond_to do |format|
        format.html
        format.csv do
          patrons = current_frame.patrons.subscribed

          csv_string = CSV.generate do |csv|
            # Header row.
            csv << [ "email" ]

            # Data rows.
            for patron in patrons
              csv << [ patron.email ]
            end
          end
          
          # Send CSV to browser.
          send_data csv_string, 
                    type: 'text/csv; charset=iso-8859-1; header=present',
                    disposition: 'attachment; filename=subscribed_patrons.csv'
        end
      end
    end
  end
end