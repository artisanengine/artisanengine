module Develop
  class DevelopController < ApplicationController
    before_filter :authenticate_engineer!
    layout        'manage'
  end
end