require "redisable/version"
require "redis"

module Redisable
  autoload :Config, "redisable/config"
  autoload :Connection, "redisable/connection"
  autoload :Key, "redisable/key"

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.send :include, Key
  end

  module ClassMethods
    attr_accessor :redis_server
    def redis
      server = redis_server || :application
      Redisable::Connection.conn(server)
    end
  end

  module InstanceMethods
    private
    def redis
      @_redis ||= self.class.redis
    end
  end
end
