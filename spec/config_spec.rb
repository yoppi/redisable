require 'spec_helper'

describe Redisable::Config do
  let(:conf) {
    {
      host: "localhost",
      port: "6379",
      db: 1,
    }
  }
  describe ".load/.conf" do
    it "store and get Redis configuration" do
      Redisable::Config.load(conf)
      Redisable::Config.conf.should == conf
    end
  end
end
