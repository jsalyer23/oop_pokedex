require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new "pokedex.rb"
DATABASE.results_as_hash = true

types = DATABASE.execute("SELECT * FROM types WHERE name='Fire' OR name='Pink';")

binding.pry

puts "didi"