# -*- coding: utf-8 -*-
module Redisable
  module Connection
    def self.conn(server)
      @pool ||= {}
      @pool[server] ||=
        begin
          conf = Redisable::Config.conf(server)
          redis = ::Redis.new(conf)
          raise "Redis server[#{conf["host"]}:#{conf["port"]}] is down!" unless reachable?(redis)
          redis
        end
    end

    def self.quit(server)
      redis = @pool[server]
      redis.quit if redis && reachable?(redis)
      @pool[server] = nil
    end

    def self.reset(server)
      quit(server)
      conn(server)
    end

    private
    def self.reachable?(redis)
      redis.ping == "PONG"
    end
  end
end
