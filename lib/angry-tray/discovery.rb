require 'socket'

module AngryTray
  class Discovery
    def initialize(what='_printer._tcp')
      @what = what
    end

    def each(&blk)
      DNSSD.browse!(@what) do |browse_result|
        puts 'browse'
        DNSSD.resolve!(browse_result) do |resolve_result|
          puts 'resolve'
          blk.call(Addrinfo.ip(resolve_result.target))
          break
        end
        break
      end
    end
  end
end
