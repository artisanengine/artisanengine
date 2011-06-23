require 'spec_helper'

describe ApplicationController do
  controller do
    def index; render nothing: true; end
  end
end