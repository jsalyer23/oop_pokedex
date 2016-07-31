MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"

	@all_pokemon = PokedexAll.new
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
		
		@api_evolution = PokeapiEvolutions.new(@evolutions, @name)

		@id = @api_data.id
		@height = @api_data.height
		@weight = @api_data.weight
		@types_ids = @api_data.get_type_id

		if @favorite == "on"
			@favorite = true
		else
			@favorite = false
		end

		@evolves = @api_evolution.evolves?

		@new_pokemon = Pokemon.new(@id, @name.capitalize, @height, @weight, @gender, @favorite, @hp, @cp, @evolves, @types_ids[0], @types_ids[1])
		@pokedex = PokedexSave.new(@new_pokemon.traits)
		@db_evolutions = DatabaseEvolutions.new(@api_evolution.evolutions, @api_species.evolution_id)

		@pokedex.save_to_database
		@db_evolutions.save_evolution_table

		@all_pokemon = PokedexAll.new

		@results = PokedexSearch.new(@name.capitalize, @all_pokemon.pokemon_array)


		# This variable shows the wrong stuff now so it needs fixed....
		# This is an Array of traits to use on the View page
		@pokemon = @results.search_by_name
		@type1 = @results.type_names[0]["name"]

		if @results.type_names[1] != nil
			@type2 = ", " + @results.type_names[1]["name"]
		else
			@type2 = ""
		end

		@stage1 = @api_evolution.evolutions[0].capitalize
		if @api_evolution.evolutions[1] != nil
			@stage2 = @api_evolution.evolutions[1].capitalize
		else
			@stage2 = ""
		end

		if @api_evolution.evolutions[2] != nil
			@stage3 = @api_evolution.evolutions[2].capitalize
		else
			@stage3 = ""
		end

	end


	erb :"pokedex/view"
end

MyApp.get "/view/:name" do
	if params[:name] != nil

		@all_pokemon = PokedexAll.new

		@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)

		@pokemon = @existing.search_by_name
		@evolutions = DatabaseEvolutions.new('', @pokemon["name"])
		@stages = @evolutions.evolution_chain

			if @existing.type_names[1] != nil
			@type1 = @existing.type_names[0]["name"]
			@type2 = ", " + @existing.type_names[1]["name"]
			else
				@type1 = @existing.type_names[0]["name"]
				@type2 = ""
			end

			@stage1 = @stages[0]["stage1"]
			if @stages[0]["stage2"] != nil
				@stage2 = @stages[0]["stage2"]
			else
				@stage2 = ""
			end

			if @stages[0]["stage3"] != nil
				@stage3 = @stages[0]["stage3"]
			else
				@stage3 = ""
			end
		
	end

	erb :"pokedex/view"
end

MyApp.get "/view/:id/:name" do
	if params[:id] != nil
		@gender = params[:gender]
		@cp = params[:cp]
		@hp = params[:hp]
		@favorite = params[:favorite]
		@id = params[:id]

		if @favorite == "on"
			@favorite = true
		else
			@favorite = false
		end

		DATABASE.execute("UPDATE pokemon SET hp=\'#{@hp}\', cp=\'#{@cp}\', gender=\'#{@gender}\', favorite=\'#{@favorite}\' 
			WHERE id=\'#{@id}\';")
	end

	@all_pokemon = PokedexAll.new
	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)
	@pokemon = @existing.search_by_name
	@evolutions = DatabaseEvolutions.new('', @pokemon["name"])
	@stages = @evolutions.evolution_chain

	if @existing.type_names[1] != nil
	@type1 = @existing.type_names[0]["name"]
	@type2 = ", " + @existing.type_names[1]["name"]
	else
		@type1 = @existing.type_names[0]["name"]
		@type2 = ""
	end

	@stage1 = @stages[0]["stage1"]
	if @stages[0]["stage2"] != nil
		@stage2 = @stages[0]["stage2"]
	else
		@stage2 = ""
	end

	if @stages[0]["stage3"] != nil
		@stage3 = @stages[0]["stage3"]
	else
		@stage3 = ""
	end

	erb :"pokedex/view"

end