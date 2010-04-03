require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end
