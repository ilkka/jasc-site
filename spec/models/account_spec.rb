require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe Account do
  it { should ensure_length_of(:password).is_at_least(6) }

  it { should validate_presence_of :email }
  it { should ensure_length_of(:email).is_at_least(3) }

  it { should validate_presence_of :username }
  it { should ensure_length_of(:username).is_at_least(3).is_at_most(20) }

end
