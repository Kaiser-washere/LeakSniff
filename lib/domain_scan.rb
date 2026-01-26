# DomainScan performs simple DNS checks and tries common subdomains from data/wordlists/subdomains.txt
# It does not perform port scanning or intrusive actions.

require 'resolv'
require 'net/http'
require 'uri'

class DomainScan
  WORDLIST = "data/wordlists/subdomains.txt"

  def self.resolve(host)
    Resolv.getaddresses(host) rescue []
  end

  def self.run(domain)
    puts "\n\033[32m[+] Analyzing domain: #{domain}\033[0m"

    # A record for root domain
    root_addrs = resolve(domain)
    if root_addrs.any?
      puts "A records for #{domain}: #{root_addrs.join(', ')}"
    else
      puts "No A records found for #{domain} (or DNS lookup failed)."
    end

    # Try common subdomains from wordlist
    if File.exist?(WORDLIST)
      puts "\nChecking common subdomains from wordlist..."
      found = []
      File.foreach(WORDLIST) do |line|
        sub = line.strip
        next if sub.empty? || sub.start_with?("#")
        host = "#{sub}.#{domain}"
        addrs = resolve(host)
        if addrs.any?
          puts "- #{host} → #{addrs.join(', ')}"
          found << host
        end
      end
      puts "No common subdomains found." if found.empty?
    else
      puts "Subdomain wordlist not found at #{WORDLIST}. Create it to enable subdomain checks."
    end

    # Try fetching root URL headers (non-intrusive)
    begin
      uri = URI("http://#{domain}")
      res = Net::HTTP.start(uri.host, uri.port, open_timeout: 3, read_timeout: 3) do |http|
        http.head("/")
      end
      puts "\nHTTP headers (http):"
      res.each_header { |k, v| puts "#{k}: #{v}" }
    rescue => _
      # ignore fetch errors
    end
  end
end
