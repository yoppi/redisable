# Redisable [![Build Status](https://travis-ci.org/yoppi/redisable.png)](https://travis-ci.org/yoppi/redisable)

Thin wrapper library for Redis, enable any Ruby class to access Redis.

## Installation

Add this line to your application's Gemfile:

    gem 'redisable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redisable

## Usage

Use in Rails application. Below redis settings in `config/redis.yml`.

```yaml
# condig/redis.yml
development:
  host: localhost
  port: 6379
  db: 1
test:
  host: localhost
  port: 6379
  db: 0
production:
  master_name: apps
  failover_reconnect_timeout: 30
  sentinels:
    - host: redis1.example.com
      port: 26379
    - host: redis2.example.com
      port: 26379
```

Then, initialize Redisable at `config/initializers/redis.rb`.

```ruby
Redisable::Config.load YAML.load_file(File.join(Rails.root, "config/redis.yml"))
```

In model, `users`, User is ActiveRecord object, but some `user_status` is ephemeral or volatile data, so won't record to RDBMS.
Below code is store `user_stauts` in Redis.

```ruby
class User < ActiveRecord::Base
  def user_status
    @user_status ||= UserStatus.new(id)
  end
end

class UserStatus
  include Redisable
  kvs_key :followers_ids
  kvs_key :unread_news_ids

  def initialize(id)
    @user_id = id
  end

  def id
    @user_id
  end

  def followers
    redis.get followers_ids
  end

  def unread_news
    redis.lrange unread_news_ids, 0, -1
  end
  ...
end

class UsersController
  def show(id)
    user_status = current_user.user_status
    user_status.followers
    user_status.unread_news
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
