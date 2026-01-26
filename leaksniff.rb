#!/usr/bin/env ruby
# LeakSniff main CLI

require_relative "lib/username_scan"
require_relative "lib/email_scan"
require_relative "lib/password_scan"
require_relative "lib/domain_scan"
require_relative "lib/metadata_scan"
require_relative "lib/offline_scan"
require "fileutils"

# Colors
RESET   = "\033[0m"
BOLD    = "\033[1m"
RED     = "\033[31m"
MAGENTA = "\033[35m"
CYAN    = "\033[36m"
GREEN   = "\033[32m"
YELLOW  = "\033[33m"

LOG_DIR = "logs"
LOG_FILE = File.join(LOG_DIR, "scan.log")
FileUtils.mkdir_p(LOG_DIR) unless Dir.exist?(LOG_DIR)

def banner
  puts "#{RED}#{BOLD}
                        :-                        
                    -- .==: -=                    
        ::       -=-==========:==       ::        
     .-.==    -   ==============   :    -=.-      
      -===. :=- -==-:.      .:-==- :=:  ===-      
       ===-==-:==: :========--  .==--==-===       
       .-=--.-=-   ======-=====-  -==.-===.       
     :- --.===.  -====-=-=======   .===.-- -:     
      =======-    -============.    -=======      
      .===--=-    :==-========.     :=--===.      
     ...---==-      -=======-       :==---.:.     
      -======-      :--.=---:       -======-      
       :==-.==    ====.-==          ==.-==:       
       .--=-===.  .====-=--====.  .===-=--:       
        :-===-==-   .---=====-   -==-===-:        
            .: :==-     =-     -==: :.            
      .-==================================-.      
       :=====@=@============##====*@#*====:       
       :====##=*@@+@*@@@@@#@@@@#@@@@@+====:       
      :==============@==+**=+==============:      
             .. .===----=-----===: ..             
                        =-                        
                        .:                        
#{RESET}"
  puts "#{CYAN}LeakSniff v0.2 — Real Breach Scanner#{RESET}"
  puts "#{YELLOW}PurpleRose Identity — CLI + Real Data + Modular Ruby#{RESET}\n\n"
end

def menu
  puts "#{MAGENTA}Select Scan Mode:#{RESET}"
  puts "  [1] Username scan (GitHub mentions)"
  puts "  [2] Email leak check (BreachDirectory)"
  puts "  [3] Password leak check (PwnedPasswords range)"
  puts "  [4] Domain exposure (DNS + subdomain wordlist)"
  puts "  [5] Metadata sniff (EXIF from local file)"
  puts "  [6] Offline CSV scan (local dataset)"
  puts "  [7] Exit"
  print "\n#{MAGENTA}Choice: #{RESET}"
  gets.strip
end

def log(entry)
  File.open(LOG_FILE, "a") do |f|
    f.puts("#{Time.now.utc.iso8601} #{entry}")
  end
end

def run(choice)
  case choice
  when "1"
    print "Enter username: "
    input = gets.strip
    log("USERNAME_SCAN #{input}")
    UsernameScan.run(input)
  when "2"
    print "Enter email: "
    input = gets.strip
    log("EMAIL_SCAN #{input}")
    EmailScan.run(input)
  when "3"
    print "Enter password: "
    input = gets.strip
    log("PASSWORD_SCAN [REDACTED]")
    PasswordScan.run(input)
  when "4"
    print "Enter domain (example.com): "
    input = gets.strip
    log("DOMAIN_SCAN #{input}")
    DomainScan.run(input)
  when "5"
    print "Enter local file path: "
    input = gets.strip
    log("METADATA_SCAN #{input}")
    MetadataScan.run(input)
  when "6"
    print "Enter email to search in local CSV: "
    input = gets.strip
    log("OFFLINE_SCAN #{input}")
    OfflineScan.run(input)
  when "7"
    puts "#{RED}Exiting LeakSniff...#{RESET}"
    exit
  else
    puts "#{RED}Invalid choice.#{RESET}"
  end
end

# Main
banner
loop do
  choice = menu
  run(choice)
  puts "\n#{CYAN}Press Enter to continue...#{RESET}"
  STDIN.gets
end
