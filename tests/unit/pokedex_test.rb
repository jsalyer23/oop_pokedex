
require 'test_helper'
require "pry"
class PokedexTest < Minitest::Test
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

    
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_all_pokemon
    pokedex_pokemon = Pokedex.all_pokemon

    assert_kind_of(Array, pokedex_pokemon)
    assert_kind_of(Object, pokedex_pokemon[0])
    assert_equal(pokedex_pokemon.count, 6)
    refute_nil(pokedex_pokemon)
  end

  def test_find_by_name
  	name_results = Pokedex.find({"id" => 5})

  	assert_kind_of(Object, name_results)
  	refute_nil(name_results)
  end

  def test_find_by_name_false
  	name_results = Pokedex.find({"id" => 8})

  	assert_kind_of(FalseClass, name_results)
  	assert_equal(false, name_results)
  	refute_nil(name_results)
  end

  def test_search_database_for_gender
  	gender_results = Pokedex.search({"search" => "Female"})

  	assert_kind_of(Array, gender_results)
    assert_kind_of(Object, gender_results[0])
  	assert_equal(3, gender_results.count)
  	refute_nil(gender_results)
  end

  def test_select_favorites
  	favorites = Pokedex.favorites

  	assert_kind_of(Array, favorites)
    assert_kind_of(Object, favorites[0])
  	assert_equal(favorites.count, 4)
  	refute_nil(favorites)
  end

  def test_display_type_names
  	display_names = Pokedex.find({"id" => 5})
    display_names = display_names.display_type_names

  	assert_equal("Fire", display_names[0])
  	assert_kind_of(Array, display_names)
  	refute_nil(display_names)
  end

  def test_2_type_ids
    @two_types = Pokedex.find({"id" => 2})
  	two_ids = @two_types.type_id

  	assert_equal(5, two_ids[0])
  	assert_equal(8, two_ids[1])
  	assert_kind_of(Array, two_ids)
  	refute_nil(two_ids)
  end

  def test_2_type_names
    @two_types = Pokedex.find({"id" => 2})
  	two_names = @two_types.type_names

  	assert_equal("Grass", two_names[0]["name"])
  	assert_equal("Poison", two_names[1]["name"])
  	assert_kind_of(Array, two_names)
  	refute_nil(two_names)
  end

  def test_show_2_names
    @two_types = Pokedex.find({"id" => 2})
  	two_names = @two_types.display_type_names

  	assert_equal("Grass", two_names[0])
  	assert_equal(", Poison", two_names[1])
  	assert_kind_of(Array, two_names)
  	refute_nil(two_names)
  end

end
