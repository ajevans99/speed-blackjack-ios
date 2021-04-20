# Convert all .swift files into public files for use in Playgrounds

require 'swift_republic'
require 'fileutils'

records = Dir.glob("./SpeedBlackjack/**/*.swift")

records.each do |r|
    begin
        make_models_public(r, "/Users/austinjevans/Downloads" + r[1..])
    rescue
        puts "Error for file :" + r
    end
end
