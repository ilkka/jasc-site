require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe Post do
  before { @post = Post.new }
  subject { @post }

  it 'can be created' do
    @post.should_not be_nil
  end

  context 'when title is empty' do
    it { should_not be_valid }
    specify { @post.save.should == false }
  end
end
