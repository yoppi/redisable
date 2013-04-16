# -*- coding: utf-8 -*-
module Redisable
  module KVSKey
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # return model_name:id:field_name
      def kvs_key(name, options={})
        klass_name ||= self.name
        define_method(name) do |id_=nil|
          id_ ||= if options[:id]
                    options[:id].call(self)
                  else
                    self.id
                  end
          KVSKey.join_key(klass_name, id_, name, options[:blank_field])
        end
        define_singleton_method(name) do |id_=nil|
          id_ ||= options[:id].call(self)
          KVSKey.join_key(klass_name, id_, name, options[:blank_field])
        end
      end
    end

    def self.join_key(klass_name, id, name, is_blank_field)
      k = "#{klass_name}"
      k << ":#{id}" if id
      k << ":#{name}" unless is_blank_field
      k
    end
  end
end
