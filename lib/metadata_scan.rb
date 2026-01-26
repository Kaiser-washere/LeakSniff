# MetadataScan extracts EXIF metadata from local image files using exifr gem.
# For other file types, minimal placeholder behavior is provided.

require 'exifr/jpeg' rescue nil

class MetadataScan
  def self.run(path)
    puts "\n\033[32m[+] Extracting metadata from: #{path}\033[0m"
    unless File.exist?(path)
      puts "File not found: #{path}"
      return
    end

    # Try EXIF for JPEG
    begin
      if defined?(EXIFR) && path.downcase.end_with?(".jpg", ".jpeg")
        exif = EXIFR::JPEG.new(path)
        if exif && exif.exif?
          puts "Camera: #{exif.model}" if exif.model
          puts "Date/Time: #{exif.date_time}" if exif.date_time
          puts "GPS: #{exif.gps}" if exif.gps
        else
          puts "No EXIF metadata found."
        end
      else
        puts "EXIF extraction not available or file type not supported by exifr gem."
      end
    rescue => e
      puts "Error reading metadata: #{e.class} #{e.message}"
    end
  end
end
