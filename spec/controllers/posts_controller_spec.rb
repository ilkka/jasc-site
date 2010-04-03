require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "PostsController" do
  before do
    @posts = []
    post = Post.new
    post.id = "1"
    post.title = "Test post 1"
    post.body = "Test post 1 body"
    @posts << post
    post = Post.new
    post.id = "2"
    post.title = "Test post 2"
    post.body = "Test post 2 body"
    @posts << post
  end

  context "when index route used" do
    before do
      Post.expects(:all).returns(@posts)
      get '/posts'
    end

    specify { last_response.should be_ok }
    it "should list all posts" do
      @posts.each do |post|
        last_response.body.should include(post.title)
        last_response.body.should include(post.body)
      end
    end
  end
end

