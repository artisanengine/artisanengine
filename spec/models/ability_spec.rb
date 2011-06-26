require 'spec_helper'
require 'cancan/matchers'

describe "Engineer Abilities:" do
  let( :user )    { Factory :user, role: 'Engineer' }
  let( :frame )   { Factory :frame }
  let( :ability ) { Ability.new( user, frame ) }
  
  it "can perform all actions on all things" do
    ability.should be_able_to :manage, User
    ability.should be_able_to :manage, Frame
    ability.should be_able_to :manage, Object
  end
end

describe "Artisan Abilities:" do
  let( :user )    { Factory :user, role: 'Artisan' }
  let( :frame )   { Factory :frame }
  let( :ability ) { Ability.new( user, frame ) }
  
  it "can create pages in their own frame only" do
    ability.should be_able_to :create, Page
  end
  
  it "can read pages in their own frame only" do
    ability.should_not be_able_to :read, Factory( :page )
    ability.should be_able_to :read, Factory( :page, frame: user.frame )
  end
end

describe "General Abilities:" do
  let( :user )    { Factory :user }
  let( :frame )   { Factory :frame }
  let( :ability ) { Ability.new( user, frame ) }
  
  it "can read pages in the current frame" do
    ability.should_not be_able_to :read, Factory( :page )
    ability.should be_able_to :read, Factory( :page, frame: frame )
  end
end