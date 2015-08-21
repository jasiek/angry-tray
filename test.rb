require 'pp'
require 'bundler'
Bundler.require
require_relative 'lib/angry-tray'

layout = File.read('templates/layout.haml')
index = File.read('templates/index.haml')
output_dir = 'output'

AngryTray::Discovery.new.each do |addrinfo|
  @printer = AngryTray::Interrogation.new(addrinfo.ip_address).interrogate
  
  haml = Haml::Engine.new(index)
  File.open(File.join(output_dir, addrinfo.ip_address + ".html"), "w") do |f|
    f << haml.render(binding)
  end
end
