require 'pp'
require 'bundler'
Bundler.require
require_relative 'lib/angry-tray'

layout = File.read('templates/layout.haml')
index = File.read('templates/index.haml')

AngryTray::Discovery.new.each do |addrinfo|
  @printer = AngryTray::Interrogation.new(addrinfo.ip_address).interrogate
  
  haml = Haml::Engine.new(index)
  File.open(ip + ".html", "w") do |f|
    f << haml.render(binding)
  end
end


sleep 1000
