module PagesHelper
  
  # Transform Textile into HTML.
  def textile( content )
    RedCloth.new( content, [ :filter_html ] ).to_html.html_safe
  end

end