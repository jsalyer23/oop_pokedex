MyApp.get "/add" do
	@title = "Add New Pok&eacute;mon"
	# @name = params[:name]
	# @pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
	erb :"pokedex/add"
end

MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"
	# Check if the Pokemon being added already exists
	@all_pokemon = PokedexAll.new
	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)
	# If it doesn't...
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
		@api_evolution = PokeapiEvolutions.new(@evolutions, @name)

		@types_ids = @api_data.get_type_id

		if @favorite == "on"
			@favorite = true
		else
			@favorite = false
		end
		# Create a new Pokemon instance containing it's traits
		@new_pokemon = Pokemon.new(@api_data.id, @name.capitalize, @api_data.height, @api_data.weight, @gender,
									 @favorite, @hp, @cp, @api_evolution.evolves?, @types_ids[0], @types_ids[1])
		# Save new Pokemon to database
		@pokedex = PokedexSave.new(@new_pokemon.traits)
		@pokedex.save_to_database
		# Save Pokemon's evolution chain to database unless the chain exists in the database already
		@db_evolutions = DatabaseEvolutions.new(@api_evolution.evolutions, @api_species.evolution_id)
		@db_evolutions.save_evolution_table
		# Create a new search for the newly added Pokemon in the database
		@all_pokemon = PokedexAll.new
		@results = PokedexSearch.new(@name.capitalize, @all_pokemon.pokemon_array)
		# Assign the Pokemon's traits to a variable for use in view.erb
		@pokemon = @results.search_by_name
		# Create new instance containing evolution table from database
		@evolutions = DatabaseEvolutions.new('', @pokemon["name"])
		# Translate type ids into id names
		@type1 = @results.display_type_names[0]
		@type2 = @results.display_type_names[1]
		# Translate evolution id into stage names
		@stage1 = @evolutions.stage1
		@stage2 = @evolutions.stage2
		@stage3 = @evolutions.stage3
	end

	erb :"pokedex/view"
end