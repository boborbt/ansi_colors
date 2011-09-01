# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ansi_colors"
  gem.homepage = "http://github.com/boborbt/ansi_colors"
  gem.license = "MIT"
  gem.summary = %Q{Adds methods to add ansi colors escape codes to the standard String class}
  gem.description = %Q{Adds methods to add ansi colors escape codes to the standard String class}
  gem.email = "boborbt@gmail.com"
  gem.authors = ["Roberto Esposito"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new