# If you ever see a Rakefile, run
#
#   rake -T
#
# to get a list of all available "rake commands."

require "rake"
require "securerandom"

def prompt(msg)
  print "#{msg} (y/n) "

  case STDIN.gets.chomp.downcase
  when "y", "yes"
    :yes
  when "n", "no"
    :no
  end
end

namespace :setup do
  desc "Set up dotenv by copying env.example to .env"
  task :dotenv do
    if File.exist?(".env")
      next if :no == prompt("The .env file already exists. Overwrite it?")
    end

    puts "Copying env.example to .env..."

    FileUtils.cp("env.example", ".env")
    File.open(".env", "a+") do |f|
      f.puts "SESSION_SECRET=#{SecureRandom.hex(64)}"
    end
  end
end

desc "Start IRB with application environment loaded"
task :console do
  exec "irb -r./setup -r./models"
end
