# -*- coding: utf-8 -*-
module Redisable
  class Config
    def self.load(conf, server=:application)
      @conf ||= {}
      @conf[server] = conf
    end

    def self.conf(server=:application)
      @conf[server]
    end
  end
end

