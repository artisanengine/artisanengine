Factory.define :page do |f|
  f.association :frame
  
  f.title       'My Page'
  f.content     'Some page content.'
end