MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"
	@file = "app/models/pokedex.csv"

	@all_pokemon = PokedexAll.new

	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)

	if @existing.search_by_name == true
		# Array of traits for an Pokemon that exists to use on View page
		@pokemon = @existing.search_by_name
		

		
	elsif @existing.search_by_name == false
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

		@id = @api_data.id
		@height = @api_data.height
		@weight = @api_data.weight
		@types_ids = @api_data.get_type_id
binding.pry
		
		@evolves = ""



		if @favorite == "on"
			@favorite = true
		else
			@favorite = false
		end

		# This looks pretty ugly...I should put it in a method and just pass in @api_evolution...
		if (@api_evolution.evolutions[0] == @name && @api_evolution.evolutions[1] == nil) ||
			(@api_evolution.evolutions[1] == @name && @api_evolution.evolutions[2] == nil) ||
			(@api_evolution.evolutions[2] == @name && @api_evolution.evolutions[3] == nil)
			@evolves = false
		else
			@evolves = true
		end

		@new_pokemon = Pokemon.new(@id, @name.capitalize, @height, @weight, @gender, @favorite, @hp, @cp, @evolves, @types_ids[0], @types_ids[1])
		@pokedex = PokedexSave.new(@new_pokemon.traits)
		@db_evolutions = DatabaseEvolutions.new(@api_evolution.evolutions, @api_species.evolution_id)

		@pokedex.save_to_database
		@db_evolutions.save_evolution_table

		# This variable shows the wrong stuff now so it needs fixed....
		# This is an Array of traits to use on the View page
		@pokemon = @new_pokemon.traits


	end


	erb :"pokedex/view"
end