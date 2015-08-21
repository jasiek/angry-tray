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
      d.supplies = fetch_supplies.map { |s| Supplies.new(s) }
    end
  end

  def fetch_name
    response = @manager.get(['1.3.6.1.2.1.25.3.2.1.3.1'])
    response.each_varbind do |vb|
      return vb.value
    end
  end

  def fetch_supplies
    @manager.get_bulk(0, 100, ['1.3.6.1.2.1.43.12']).each_varbind do |vb|
      pp vb
    end
  end
end
