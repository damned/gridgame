require 'bundler/setup'

task default: ['test']

task 'test' do
  system 'rspec'
end

task 'run' do
  require_relative 'lib/ui/gridgame_console_runner'
  GridgameConsoleRunner.new.run
end

task 'shoes' do
  check_ruby_for_shoes
  codelines = [
    'require "./lib/ui/gridgame_shoes_runner"',
    'GridgameShoesRunner.new.run'
  ]
  system "ruby -e '#{codelines.join "\n"}'"
end

def check_ruby_for_shoes
  ruby_version = `ruby -v`
  required_jruby_version = '9.1.7.0'
  unless ruby_version.include? required_jruby_version
    puts "need to be running jruby #{required_jruby_version} - e.g. use:"
    puts
    puts "rvm use jruby-#{required_jruby_version}@gridgame --create"
    puts 'bundle install'
    puts 'bundle exec rake shoes'
    puts
    exit 1
  end
end

