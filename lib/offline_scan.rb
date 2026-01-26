# OfflineScan searches a local CSV file data/breaches.csv for matching email entries.
# CSV columns expected: email,source,date

require 'csv'

class OfflineScan
  CSV_PATH = "data/breaches.csv"

  def self.run(email)
    puts "\n\033[32m[+] Scanning local dataset for: #{email}\033[0m"
    unless File.exist?(CSV_PATH)
      puts "Local dataset not found at #{CSV_PATH}."
      return
    end

    found = false
    CSV.foreach(CSV_PATH, headers: true) do |row|
      if row["email"] && row["email"].strip.downcase == email.strip.downcase
        puts "Found in: #{row['source']} (#{row['date']})"
        found = true
      end
    end
    puts "No local match found." unless found
  end
end
