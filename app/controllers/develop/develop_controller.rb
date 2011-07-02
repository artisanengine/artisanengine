module Develop
  class DevelopController < ApplicationController
    layout 'develop'
    
    before_filter :authenticate_engineer!
    
    def interface
    end
  end
end