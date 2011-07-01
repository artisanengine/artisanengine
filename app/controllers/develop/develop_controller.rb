module Develop
  class DevelopController < ApplicationController
    before_filter :authenticate_engineer!
    layout 'develop'
  end
end