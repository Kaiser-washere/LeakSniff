require 'net/http'
require 'json'
require 'uri'

class UsernameScan
  TOKEN = ENV["GITHUB_TOKEN"] # Ortam değişkeninden token al

  def self.run(username)
    puts "\n\033[32m[+] Scanning username: #{username}\033[0m"
    query = URI.encode_www_form_component(username)
    uri = URI("https://api.github.com/search/code?q=#{query}")
    req = Net::HTTP::Get.new(uri)
    req['User-Agent'] = "LeakSniff-Ruby"
    req['Authorization'] = "token #{TOKEN}" if TOKEN

    begin
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      if res.code == "200"
        data = JSON.parse(res.body)
        count = data["total_count"] || 0
        puts "Found #{count} public mentions of '#{username}' on GitHub."
        items = data["items"] || []
        items[0..4].each do |item|
          repo = item.dig("repository", "full_name") || "unknown"
          url = item["html_url"] || item["url"]
          puts "- #{repo} → #{url}"
        end
      else
        puts "GitHub API returned: #{res.code} #{res.message}"
      end
    rescue => e
      puts "Error during GitHub query: #{e.class} #{e.message}"
    end
  end
end
