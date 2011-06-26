require 'spec_helper'
require 'cancan/matchers'

describe "Abilities:" do
  let( :my_frame )      { Factory :frame }
  let( :other_frame )   { Factory :frame }
  let( :current_frame ) { Factory :frame }
  let( :ability )       { Ability.new( user, current_frame ) }

  context "Engineer Abilities:" do
    let( :user ) { Factory :user, role: 'Engineer', frame: my_frame }
  
    it "can perform all actions on all things" do
      ability.should be_able_to :manage, User
      ability.should be_able_to :manage, Frame
      ability.should be_able_to :manage, Object
    end
  end

  context "Artisan Abilities:" do
    let( :user ) { Factory :user, role: 'Artisan', frame: my_frame }
  
    it "can only create pages in their own frame" do
      ability.should be_able_to :create,     Factory.build( :page, frame: my_frame )
      ability.should_not be_able_to :create, Factory.build( :page, frame: other_frame )
    end
  
    it "can only read pages in their own frame" do
      ability.should_not be_able_to :read, Factory( :page, frame: other_frame )
      ability.should be_able_to :read,     Factory( :page, frame: my_frame )
    end
  end

  context "Visitor Abilities:" do
    let( :user ) { Factory :user }
  
    it "can read pages in the current frame" do
      ability.should_not be_able_to :read, Factory( :page, frame: other_frame )
      ability.should be_able_to :read,     Factory( :page, frame: current_frame )
    end
  end
end