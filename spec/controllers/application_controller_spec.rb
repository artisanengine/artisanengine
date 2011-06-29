require 'spec_helper'

describe ApplicationController do
  before do
    Frame.generate domain: 'test.host', name: 'Test Frame'
  end
  
  controller do
    def index
      render nothing: true
    end
  end
  
  it "checks authorization for all actions" do
    expect {
      get :index
    }.to raise_error CanCan::AuthorizationNotPerformed
  end
end