# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Reporte::Application.initialize!

require 'rubygems'
require 'rubygems/gem_runner'
ENV['GEM_PATH'] = '/home/trancar1/ruby/gems'
Gem.clear_paths
