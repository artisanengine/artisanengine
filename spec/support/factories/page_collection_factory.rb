Factory.define :page_collection do |d|
  d.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  d.name        { Faker::Address.us_state.pluralize }
end