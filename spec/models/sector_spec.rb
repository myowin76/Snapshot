require File.dirname(__FILE__) + '/../spec_helper'

describe Sector do
  it "should be valid" do
    Sector.new.should be_valid
  end
end
