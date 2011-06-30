module Manage
  class ManageController < ApplicationController
    before_filter :authenticate_artisan!
    
    include FramesHelper  # Helpers for managing the current frame.
  end
end