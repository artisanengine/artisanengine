class Page < ActiveRecord::Base
  belongs_to :frame
  validates_presence_of :title, :content, :frame
end
