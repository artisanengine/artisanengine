module ArtisanEngine
  module Textiling
    
    # Transform Textile into HTML.
    def self.textile( content )
      RedCloth.new( content, [ :filter_html ] ).to_html
    end
    
  end
end