require 'spec_helper'

class User
  include Redisable
end

describe Redisable do
  it "autoload modules" do
    defined?(Redisable::Config).should == "constant"
    defined?(Redisable::Connection).should == "constant"
    defined?(Redisable::KVSKey).should == "constant"
  end

  describe "Include module" do
    it "define kvs_key method" do
      defined?(User.kvs_key).should == "method"
    end
    it "define redis method" do
      defined?(User.redis).should == "method"
    end
    it "define redis instance method" do
      defined?(User.new.send(:redis)).should == "method"
    end
  end
end
