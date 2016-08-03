require 'pry'
require 'test_helper'

class PokemonSaveTest < Minitest::Test
  def setup
    super
    DATABASE.execute("DELETE FROM pokemon;")

    DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2)
     VALUES (7, 'Squirtle', 5, 90, 'Male', 'true', 398, 39, CURRENT_DATE, 'true', 3, ''),
    (43, 'Oddish', 5, 54, 'Female', 'false', 100, 34, CURRENT_DATE, 'true', 5, 8),
    (25, 'Pikachu', 4, 60, 'Female', 'true', 99, 58, CURRENT_DATE, 'true', 4, ''),
    (9, 'Blastoise', 16, 855, 'Male', 'false', 93, 485, CURRENT_DATE, 'false', 3, ''),
    (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, '');")
    
    @pokemon = Pokemon.new('', 74, 'Geodude', 4, 200, 'Male', true, 299, 78, true, 9, 13)
    @pokedex = Pokemon.save(@pokemon)
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_for_saved_pokemon
    @geodude = Pokedex.find(6)

    assert_kind_of(Object, @geodude)
    refute_nil(@geodude)
    assert_equal(6, @geodude.id)
  end

  def test_updating_pokemon
  	Pokemon.update(100, 23, 'Male', true, 6)
  	new_geodude = Pokedex.find(6)

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
