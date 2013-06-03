require 'spec_helper'

class User
  include Redisable
end

describe Redisable do
  it "autoload modules" do
    defined?(Redisable::Config).should == "constant"
    defined?(Redisable::Connection).should == "constant"
    defined?(Redisable::Key).should == "constant"
  end

  describe "Include module" do
    it "define redis_key method" do
      defined?(User.redis_key).should == "method"
    end
    it "define redis method" do
      defined?(User.redis).should == "method"
    end
    it "define redis instance method" do
      defined?(User.new.send(:redis)).should == "method"
    end
  end
end
