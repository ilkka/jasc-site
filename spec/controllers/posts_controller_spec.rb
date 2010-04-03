require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "PostsController" do
  before do
    @account = Account.new(:email => 'foo@bar.com')
    @posts = []
    @post1 = Post.new(:title => "Test post 1 title", :body => "Test post 1 body", :account => @account)
    @post1.id = '1'
    @posts << @post1
    @post2 = Post.new(:title => "Test post 2 title", :body => "Test post 2 body", :account => @account)
    @post2.id = '2'
    @posts << @post2
    @post3 = Post.new(:title => "Test post 3 title", :body => "Test post 3 body", :account => @account)
    @post3.id = '3'
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
        last_response.body.should include(post.account.email)
      end
    end
  end

  context "when showing a single post" do
    before do
      Post.expects(:find_by_id).with('3').returns @post3
      get '/posts/show/3'
    end

    specify { last_response.should be_ok }
    it "should show that post" do
      last_response.body.should include(@post3.title)
      last_response.body.should include(@post3.body)
      last_response.body.should include(@post3.account.email)
    end
  end
end

