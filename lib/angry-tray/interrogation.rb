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
    puts 'pre get'
    response = @manager.get(['sysName.0'])
    puts 'post get'
    response.each_varbind do |vb|
      puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
    end
  end
end
