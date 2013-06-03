# -*- coding: utf-8 -*-
require 'spec_helper'

class User
  include Redisable::Key
end

describe Redisable::Key do
  describe ".join_key" do
    context "Field name is not blank" do
      it "join with ':' specified key, id and name" do
        Redisable::Key.join_key("user", "100", "status", false).should == "user:100:status"
      end
    end

    context "Field name is blank" do
      it "join with ':' specified key, id" do
        Redisable::Key.join_key("user", "100", "status", true).should == "user:100"
      end
    end
  end

  describe "to include" do
    it "defined 'redis_key' method" do
      defined?(User.redis_key).should == "method"
    end
  end
end
