MyApp.get "/add" do
	@title = "Add New Pok&eacute;mon"
	@file = "/models/pokedex.csv"

	@all_pokemon = PokedexAll.new(@file)

	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)

	if @existing.search_by_name == false
		@name = params[:name]
		@gender = params[:gender]
		@cp = params[:cp]
		@hp = params[:hp]
		@favorite = params[:favorite]
		@pokemon_request = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
		# Use for height and weight and types
		@api_data = Pokeapi.new(@pokemon_request)

		@species = HTTParty.get(@api_data.species_url)
		# Use for evolution id basically
		@api_species = PokeapiSpecies.new(@species)

		@evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@api_species.evolution_id}")
		# Use for evolutions
		@api_evolution = PokeapiEvolutions.new(@evolutions)

		@height = @api_data.height
		@weight = @api_data.weight
		@stage1 = @api_evolution.stage1.capitalize
		@stage2 = @api_evolution.stage2.capitalize
		@stage3 = @api_evolution.stage3.capitalize
		@types = @api_data.types

		@pokemon = Pokemon.new(@name.capitalize, @height, @weight, @gender, @cp, @hp, @favorite, @stage1, @stage2, @stage3, @types)
		@pokedex = PokedexSave.new(@pokemon, @file)
		@pokedex.save_pokemon

	else
		@pokemon = @existing.search_by_name
		return true

	end


	erb :"pokedex/add"
end