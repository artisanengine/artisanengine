Factory.define :blog do |b|
  b.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  b.name        { |b| "#{ b.frame.name } Blog" }
end