require 'pry'
require 'test_helper'

class PokemonSaveTest < Minitest::Test
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
    (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, '', '');")
    
    pokehash = {"id" => "", "name" => "Geodude", "height" => 4, "weight" => 200, "gender" => "Male", "cp" => 221, "hp" => 45,
    "favorite" => true, "evolves" => true, "type1" => 9, "type2" => 13, "pokedex_id" => 74, "evolution_id" => ''}

    @pokemon = Pokemon.new(pokehash)
    @pokedex = Pokemon.save(@pokemon)
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_for_saved_pokemon
    @geodude = Pokedex.find({"id" => 6})

    assert_kind_of(Object, @geodude)
    refute_nil(@geodude)
    assert_equal(6, @geodude.id)
  end

  def test_updating_pokemon
    update_hash = {"cp" => 100, "hp" => 23, "gender" => 'Male', "favorite" => true, "id" => 6}
  	Pokemon.update(update_hash)
  	new_geodude = Pokedex.find({"id" => 6})

  	refute_nil(new_geodude)
  	assert_kind_of(Object, new_geodude)
  	assert_equal("Male", new_geodude.gender)
  end

  def test_pokedex_save

    assert_equal(6, @pokedex.id)
    refute_nil(@pokedex)
    assert_kind_of(Object, @pokedex)
  end
end



# 74, 'Geodude', 4, 200, 'Male', true, 299, 78, true, 9, 13
