# PasswordScan uses the PwnedPasswords k-Anonymity range API (no API key).
# It sends SHA1 prefix and checks suffixes returned.

require 'digest'
require 'net/http'
require 'uri'

class PasswordScan
  def self.run(password)
    sha1 = Digest::SHA1.hexdigest(password).upcase
    prefix = sha1[0..4]
    suffix = sha1[5..-1]

    puts "\n\033[32m[+] Checking password hash prefix: #{prefix}...\033[0m"
    uri = URI("https://api.pwnedpasswords.com/range/#{prefix}")

    begin
      res = Net::HTTP.get(uri)
      found = false
      res.each_line do |line|
        line_suffix, count = line.strip.split(":")
        if line_suffix == suffix
          puts "⚠️  Password FOUND in breach database (count: #{count})."
          found = true
          break
        end
      end
      puts "✅ Password not found in known leaks." unless found
    rescue => e
      puts "Error querying PwnedPasswords: #{e.class} #{e.message}"
    end
  end
end
