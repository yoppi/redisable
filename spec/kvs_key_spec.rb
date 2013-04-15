# -*- coding: utf-8 -*-
require 'spec_helper'

class User
  include Redisable::KVSKey
end

describe Redisable::KVSKey do
  describe ".join_key" do
    context "Field name is not blank" do
      it "join with ':' specified key, id and name" do
        Redisable::KVSKey.join_key("user", "100", "status", false).should == "user:100:status"
      end
    end

    context "Field name is blank" do
      it "join with ':' specified key, id" do
        Redisable::KVSKey.join_key("user", "100", "status", true).should == "user:100"
      end
    end
  end

  describe "to include" do
    it "defined 'kvs_key' method" do
      defined?(User.kvs_key).should == "method"
    end
  end
end
