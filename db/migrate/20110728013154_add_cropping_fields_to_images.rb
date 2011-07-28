class AddCroppingFieldsToImages < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.string :primary_cropping
      t.string :secondary_cropping
    end
  end
end
