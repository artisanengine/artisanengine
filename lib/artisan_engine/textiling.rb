module ArtisanEngine
  module Textiling
    
    # Transform Textile into HTML.
    def self.textile( content )
      return "" if content.blank?
      RedCloth.new( content, [ :filter_html ] ).to_html
    end
    
  end
end