class Frame < ActiveRecord::Base
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
end
