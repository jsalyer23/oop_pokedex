MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"
	@file = "app/models/pokedex.csv"

	@all_pokemon = PokedexAll.new(@file)

	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)

	if @existing.search_by_name == false
		@name = params[:name].downcase
		@gender = params[:gender]
		@cp = params[:cp]
		@hp = params[:hp]
		@favorite = params[:favorite]
		# Use for height and weight and types
		@pokemon_request = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
		
		@api_data = Pokeapi.new(@pokemon_request)
		# Use for evolution id basically
		@species = HTTParty.get(@api_data.species_url)
		
		@api_species = PokeapiSpecies.new(@species)
		# Use for evolutions
		@evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@api_species.evolution_id}")
		
		@api_evolution = PokeapiEvolutions.new(@evolutions)

		@height = @api_data.height
		@weight = @api_data.weight
		@stage1 = @api_evolution.stage1.capitalize
		@stage2 = @api_evolution.stage2.capitalize
		@stage3 = @api_evolution.stage3.capitalize
		@types = @api_data.types

		@new_pokemon = Pokemon.new(@name.capitalize, @height, @weight, @gender, @cp, @hp, @favorite, @stage1, @stage2, @stage3, @types)
		@pokedex = PokedexSave.new(@new_pokemon.traits, @file)
		@pokedex.save_pokemon
		# This is an Array of traits to use on the View page
		@pokemon = @new_pokemon.traits
	else
		# Array of traits for an Pokemon that exists to use on View page
		@pokemon = @existing.search_by_name
		return true

	end


	erb :"pokedex/view"
end