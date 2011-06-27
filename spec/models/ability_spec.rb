require 'spec_helper'
require 'cancan/matchers'

describe "Abilities:" do
  let( :my_frame )      { Frame.generate }
  let( :other_frame )   { Frame.generate }
  let( :current_frame ) { Frame.generate }
  let( :ability )       { Ability.new( user, current_frame ) }

  context "Engineer Abilities:" do
    let( :user ) { Factory :engineer, frame: my_frame }
  
    it "can perform all actions on all things" do
      ability.should be_able_to :manage, User
      ability.should be_able_to :manage, Frame
      ability.should be_able_to :manage, Object
    end
  end

  context "Artisan Abilities:" do
    let( :user ) { Factory :artisan, frame: my_frame }
  
    it "can manage pages in their own frame" do
      ability.should be_able_to :manage,     Page.spawn( frame: my_frame )
      ability.should_not be_able_to :manage, Page.spawn( frame: other_frame )
    end
  
    it "can manage images in their own frame" do
      ability.should be_able_to :manage,     Image.spawn( frame: my_frame )
      ability.should_not be_able_to :manage, Image.spawn( frame: other_frame )
    end
  end

  context "Visitor Abilities:" do
    let( :user ) { Factory :user }
  
    it "can only read pages in the current frame" do
      ability.should be_able_to :read,     Page.generate( frame: current_frame )
      ability.should_not be_able_to :read, Page.generate( frame: other_frame )
    end
    
    it "can only read images in the current frame" do
      ability.should be_able_to :read,     Image.spawn( frame: current_frame )
      ability.should_not be_able_to :read, Image.spawn( frame: other_frame )
    end
  end
end