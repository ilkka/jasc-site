require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "PostsController" do
  before do
    @posts = []
    @post1 = Post.new
    @post1.id = "1"
    @post1.title = "Test post 1 title"
    @post1.body = "Test post 1 body"
    @posts << @post1
    @post2 = Post.new
    @post2.id = "2"
    @post2.title = "Test post 2 title"
    @post2.body = "Test post 2 body"
    @posts << @post2
    @post3 = Post.new
    @post3.id = "3"
    @post3.title = "Test post 3 title"
    @post3.body = "Test post 3 body"
    @posts << @post3
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

  context "when showing a single post" do
    before do
      Post.expects(:find_by_id).with(3).returns @post3
      get '/posts/show/3'
    end

    specify { last_response.should be_ok }
    it "should show that post" do
      @response.body.should include(@post3.title)
      @response.body.should include(@post3.body)
    end
  end
end

