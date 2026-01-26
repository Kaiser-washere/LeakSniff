require 'open-uri'
require 'json'

class EmailScan
  def self.run(email)
    puts "\n\033[32m[+] Querying BreachDirectory for: #{email}\033[0m"
    url = "https://breachdirectory.org/api/?func=auto&term=#{URI.encode_www_form_component(email)}"

    begin
      res = URI.open(url).read
      data = JSON.parse(res) rescue nil
      if data && data["success"] && data["result"].is_a?(Array) && !data["result"].empty?
        puts "Possible leaks found (partial lines):"
        data["result"].each_with_index do |r, idx|
          puts "#{idx+1}. #{r['line']}"
          break if idx >= 9
        end
      else
        puts "No leaks found for #{email} (or service returned no results)."
      end
    rescue => e
      puts "Error querying BreachDirectory: #{e.class} #{e.message}"
    end
  end
end
