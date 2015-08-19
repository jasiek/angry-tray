require 'pp'
require 'bundler'
Bundler.require
require_relative 'lib/angry-tray'

AngryTray::Discovery.new.each { |d| pp d }

