module Develop
  class DevelopController < ApplicationController
    before_filter :authenticate_engineer!
  end
end