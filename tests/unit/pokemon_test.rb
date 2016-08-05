require 'test_helper'
require 'pry'


class PokemonTest < Minitest::Test
  def setup
    super

    DATABASE.execute("DELETE FROM pokemon;")
    DATABASE.execute("DELETE FROM evolutions;")
    DATABASE.execute("INSERT INTO evolutions (evolution_id, stage1, stage2, stage3) VALUES (3, 'squirtle', 'wartortle', 'blastoise');")
    DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, height, weight, gender, favorite, hp, cp, date_added, evolves, type1, type2, evolution_id)
     VALUES (7, 'Squirtle', 5, 90, 'Male', 'true', 398, 39, CURRENT_DATE, 'true', 3, '', 3),
    (43, 'Oddish', 5, 54, 'Female', 'false', 100, 34, CURRENT_DATE, 'true', 5, 8, ''),
    (25, 'Pikachu', 4, 60, 'Female', 'true', 99, 58, CURRENT_DATE, 'true', 4, '', ''),
    (9, 'Blastoise', 16, 855, 'Male', 'false', 93, 485, CURRENT_DATE, 'false', 3, '', 3),
    (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, '', ''),
    (74, 'Geodude', 4, 200, 'Male', 'true', 100, 23, CURRENT_DATE, 'true', 9, 13, '');")
   
    traits_hash = {"id" => "", "name" => "Pidgey", "height" => 23, "weight" => 44, "gender" => "Male", "cp" => 22, "hp" => 45,
                    "favorite" => false, "evolves" => true, "type1" => "Normal", "type2" => "Flying", "pokedex_id" => 24, "evoltuion_id" => ''}
    @pokemon = Pokemon.new(traits_hash)
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