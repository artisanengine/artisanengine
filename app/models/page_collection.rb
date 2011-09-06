class PageCollection < ActiveRecord::Base
  belongs_to :frame
  validates_presence_of :frame, :name
end
