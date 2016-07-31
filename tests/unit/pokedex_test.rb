require 'test_helper'


class PokemonTest < Minitest::Test
  def setup
    super
   
    @input = "Oddish"
    @all_pokemon = PokedexAll.new
    @search = PokedexSearch.new(@input, @all_pokemon.all_pokemon)


   
 
    # This setup will automatically be run before each test below.
  end

  # -------------PokedexAll TESTS------------------

  def test_all_pokemon
    pokedex_pokemon = @all_pokemon.all_pokemon

    assert_kind_of(Array, pokedex_pokemon)
    assert_equal(20, pokedex_pokemon.count)
  end

  def test_pokemon_array
    pokedex_pokemon = @all_pokemon.pokemon_array

    assert_kind_of(Array, pokedex_pokemon)
    assert_equal(20, pokedex_pokemon.count)
  end


end