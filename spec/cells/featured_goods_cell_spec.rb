require 'spec_helper'

describe FeaturedGoodsCell do
  context "display: " do
    let( :frame )        { Frame.generate domain: 'test.host' }
    let( :display_case ) { frame.display_cases.first } # Auto-generated on frame creation.
    
    let( :cell )  { render_cell( :featured_goods, :display, frame: frame ) }
    
    before do
      # Given there are three Featured goods in the featured case,
      display_case.goods << Good.spawn( name: 'Product 1' )
      display_case.goods << Good.spawn( name: 'Product 2' )
      display_case.goods << Good.spawn( name: 'Product 3' )
    end
    
    it "shows the first featured good in the case by default" do      
      cell.should have_content     'Product 1'
      cell.should_not have_content 'Product 2'
      cell.should_not have_content 'Product 3'
    end
    
    it "shows as many goods as the limit argument requests" do
      cell = render_cell( :featured_goods, :display, frame: frame, limit: 3 )
      
      cell.should have_content 'Product 1'
      cell.should have_content 'Product 2'
      cell.should have_content 'Product 3'
    end
  end
end