require 'test_helper'


class PokemonTest < Minitest::Test
  def setup
    super
   
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

  def test_pokemon_traits
    traits = @pokemon.traits

    assert_kind_of(Array, traits)
    assert_equal(11, traits.length)
    assert_equal("Normal", traits[9])
  end


end