xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title blog.name
    # xml.description "The Emmy's Organics Blog"
    xml.link '/blog'

    for post in posts
      xml.item do
        xml.title         post.title
        xml.description   post.content
        xml.pubDate       post.published_on.to_s(:rfc822)
        xml.link          path_for_post(post)
        xml.guid          path_for_post(post)
      end
    end
  end
end