class Post < ActiveRecord::Base
  attr_accessible :title, :content
  
  belongs_to :blog
  
  validates_presence_of :title, :content, :blog
end