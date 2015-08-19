module AngryTray
  class Discovery
    def initialize(what='_printer._tcp')
      @what = what
    end

    def each(&blk)
      DNSSD.browse!(@what) do |browse_result|
        DNSSD.resolve!(browse_result) do |resolve_result|
          DNSSD::Service.getaddrinfo(resolve_result.target) do |addrinfo|
            blk.call(addrinfo.address)
          end
        end
      end
    end
  end
end
