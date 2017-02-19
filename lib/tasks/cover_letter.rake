namespace :cover_letter do
  desc "TODO"
  task setup: :environment do
    puts "Creating database file: config/database.yml"
    system "cp config/database.yml.example config/database.yml"
    puts "Set password to?:"
    password = STDIN.noecho(&:gets).chomp
    open('config/application.yml', 'a') do |f|
      f.puts "SECRET: '#{password}'"
    end
    puts "Password set in config/application.yml"
  end
end
