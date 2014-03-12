# -*- coding: utf-8 -*-
require 'redis/distributed'

module Redisable
  module Connection
    def self.conn(server)
      @pool ||= {}
      @pool[server] ||=
        begin
          conf = Redisable::Config.conf(server)
          redis = nil
          if conf.is_a?(Array)
            redis = ::Redis::Distributed.new(conf)
            redis.nodes.each do |node|
              raise "Redis server[#{node.id}] is down!" unless reachable?(node)
            end
          else
            redis = ::Redis.new(conf)
            raise "Redis server[#{redis.id}] is down!" unless reachable?(redis)
          end
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
