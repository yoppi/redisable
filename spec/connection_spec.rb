# -*- coding: utf-8 -*-
require 'spec_helper'

describe Redisable::Connection do
  let(:server) {:application}
  let(:conf) {
    {
      host: "localhost",
      port: "6379",
      db: "1",
    }
  }
  describe ".conn" do
    context "in access ':application' first time" do
      it "create connection" do
        Redisable::Config.stub(:conf) { conf }
        Redis.any_instance.stub(:ping) { "PONG" }
        Redisable::Connection.conn(server)
        Redisable::Connection.instance_variable_get("@pool").size.should == 1
      end
      after do
        Redisable::Connection.instance_variable_set("@pool", {})
      end
    end
    context "in request timeout" do
      it "raise RuntimeError" do
        Redisable::Config.stub(:conf) { conf }
        Redis.any_instance.stub(:ping) { "" }
        expect {
          Redisable::Connection.conn(server)
        }.to raise_error(RuntimeError)
      end
    end
  end
end
