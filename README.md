# Capistrano::Logrotate

[![Code Climate](http://img.shields.io/codeclimate/github/linjunpop/capistrano-logrotate.svg)](https://codeclimate.com/github/linjunpop/capistrano-logrotate)
[![Gem Version](http://img.shields.io/gem/v/capistrano-logrotate.svg)](https://rubygems.org/gems/capistrano-logrotate)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-logrotate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-logrotate

## Usage

```ruby
# Capfile

require 'capistrano/logrotate'
```

then you can use `cap logrotate:config'

Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting

```ruby
set :logrotate_role, :app
set :logrotate_conf_path, -> { File.join('/etc', 'logrotate.d', "#{fetch(:application)}_#{fetch(:stage)}") }
set :logrotate_log_path, -> { File.join(shared_path, 'log') }
set :logrotate_logs_keep, -> { 12 }
set :logrotate_user, -> { fetch(:user) }
set :logrotate_group, -> { fetch(:user) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/capistrano-logrotate.
