require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe Post do
  before { @post = Post.new }
  subject { @post }

  it 'can be created' do
    @post.should_not be_nil
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  
end
