# Load the rails application
require File.expand_path('../application', __FILE__)
Gem.clear_paths
ENV['GEM_HOME'] = '/home/trancar1/ruby/gems'
ENV['GEM_PATH'] = File.expand_path('~/.rbenv/bin') + ':~/.rbenv/shims'
 
require 'rubygems'
require 'bundler'
 
Bundler.require

# Initialize the rails application
Reporte::Application.initialize!