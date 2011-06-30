module Visit
  class VisitController < ApplicationController
    layout 'visit'
    
    include ArtisanEngine::Theming  # Filters and methods for theming.
    include FramesHelper            # Helpers for managing the current frame.
  end
end