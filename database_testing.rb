require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new "pokedex.rb"
DATABASE.results_as_hash = true


evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
binding.pry
		evolution_table.each do |row|
			if row["evolution_id"] == @id
				return true
			end
		end



		id          pokedex_id  name        weight      height      gender      favorite    hp          cp          date_added  evolves     type1       type2
----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
7, 'Squirtle', 5, 90, 'Male', true, 398, 39, CURRENT_DATE, true, 3, ''
43, 'Oddish', 5, 54, 'Female', false, 100, 34, CURRENT_DATE, true, 5, 8
25, 'Pikachu', 4, 60, 'Female', true, 99, 58, CURRENT_DATE, true, 4, ''
9, 'Blastoise', 16, 855, 'Male', false, 93, 485, CURRENT_DATE, false, 3, ''
37, 'Vulpix', 6, 99, 'Female', true, 499, 89, CURRENT_DATE, true, 2, ''
74, 'Geodude', 4, 200, 'Male', true, 100, 23, CURRENT_DATE, true, 9, 13


evolution_id  stage1      stage2      stage3
------------  ----------  ----------  ----------
5             weedle      kakuna      beedrill
3             squirtle    wartortle   blastoise
18            oddish      gloom       vileplume
10            pichu       pikachu     raichu
2             charmander  charmeleon  charizard
29            bellsprout  weepinbell  victreebel
1             bulbasaur   ivysaur     venusaur
15            vulpix      ninetales
76            dratini     dragonair   dragonite
67            eevee       vaporeon
25            growlithe   arcanine
7             rattata     raticate
4             caterpie    metapod     butterfree
31            geodude     graveler    golem
40            gastly      haunter     gengar
72            munchlax    snorlax
27            abra        kadabra     alakazam
21            diglett     dugtrio
6             pidgey      pidgeotto   pidgeot

