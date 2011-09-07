class PageCollection < ActiveRecord::Base
  belongs_to :frame
  validates_presence_of :frame, :name
  has_many :page_collects
  has_many :pages, through: :page_collects
end
