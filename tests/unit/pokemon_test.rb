require 'test_helper'


class PokemonTest < Minitest::Test
  def setup
    super

    DATABASE.execute("DELETE FROM pokemon;")

    DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2)
     VALUES (7, 'Squirtle', 5, 90, 'Male', 'true', 398, 39, CURRENT_DATE, 'true', 3, ''),
    (43, 'Oddish', 5, 54, 'Female', 'false', 100, 34, CURRENT_DATE, 'true', 5, 8),
    (25, 'Pikachu', 4, 60, 'Female', 'true', 99, 58, CURRENT_DATE, 'true', 4, ''),
    (9, 'Blastoise', 16, 855, 'Male', 'false', 93, 485, CURRENT_DATE, 'false', 3, ''),
    (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, ''),
    (74, 'Geodude', 4, 200, 'Male', 'true', 100, 23, CURRENT_DATE, 'true', 9, 13);")
   
    @pokemon = Pokemon.new
    @pokemon.name = "Pidgey"
    @pokemon.height = 23
    @pokemon.weight = 44
    @pokemon.gender = "Male"
    @pokemon.cp = 22
    @pokemon.hp = 45
    @pokemon.favorite = false
    @pokemon.evolves = true
    @pokemon.type1 = "Normal"
    @pokemon.type2 = "Flying"
    @pokemon.pokedex_id = 24
    # This setup will automatically be run before each test below.
  end


  def test_new_pokemon
    pidgey = @pokemon

    assert_equal("Pidgey", pidgey.name)
    assert_equal("Male", pidgey.gender)
    assert_kind_of(TrueClass, pidgey.evolves)
    assert_kind_of(Integer, pidgey.pokedex_id)
  end

end