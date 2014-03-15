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
    before do
      Redisable::Config.stub(:conf) { conf }
      Redis.any_instance.stub(:ping) { "PONG" }
    end
    after do
      Redisable::Connection.instance_variable_set("@pool", {})
    end
    subject { Redisable::Connection.conn(server) }
    context "in access ':application' first time" do
      it "create connection" do
        subject
        Redisable::Connection.instance_variable_get("@pool").size.should == 1
      end
    end
    context "sharding conf" do
      let(:conf) {
        [
          {
            host: "localhost",
            port: "6379",
            db: "1",
          },
          {
            host: "localhost",
            port: "6379",
            db: "2",
          },
        ]
      }
      it "create sharding connection" do
        expect(subject).to be_a(Redis::Distributed)
      end
    end
    context "in request timeout" do
      before do
        Redisable::Config.stub(:conf) { conf }
        Redis.any_instance.stub(:ping) { "" }
      end
      it "raise RuntimeError" do
        expect {subject}.to raise_error(RuntimeError)
      end
    end
  end

end
