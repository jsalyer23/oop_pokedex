require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new "pokedex.rb"
DATABASE.results_as_hash = true

pokemon = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='squirtle';")

binding.pry

puts "didi"


