class AngryTray::Interrogation
  def initialize(ip)
    @ip = ip
    @manager = SNMP::Manager.new(host: ip)
  end

  def interrogate
    puts 'interrogate'
    Device.new.tap do |d|
      d.name = fetch_name
      d.ip = @ip
    end
  end

  def fetch_name
    response = @manager.get(['1.3.6.1.2.1.25.3.2.1.3.1'])
    response.each_varbind do |vb|
      return vb.value
    end
  end
end
