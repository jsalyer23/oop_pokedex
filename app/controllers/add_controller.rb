MyApp.get "/add" do
	@title = "Add New Pok&eacute;mon"
	erb :"pokedex/add"
end

MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"
	# Check if the Pokemon being added already exists
	@search = Pokedex.search({"name"=>params[:name]})
	# If it doesn't...
	if @search[0] == nil
		# Use for height and weight and types
		@api = ApiRequests.new
		@api_data = @api.pokemon_request(params[:name].downcase)
		# Use for evolution id basically
		@api_species = @api.species_request(@api_data)
		# Use for evolutions
		@api_evolution	= @api.evolution_request(@api_species, params[:name].downcase)
		@types_ids = @api_data.get_type_id
		if params[:favorite] == "on"
			@favorite = true
		else
			@favorite = false
		end
		@pokemon_traits = {"id"=>"", "pokedex_id"=>@api_data.id, "name"=>params[:name].capitalize, "height"=>@api_data.height,
						"weight"=>@api_data.weight, "gender"=>params[:gender], "favorite"=>@favorite, "hp"=>params[:hp], "cp"=>params[:cp],
						"evolves"=>@api_evolution.evolves?, "type1"=>@types_ids[0], "type2"=>@types_ids[1], "evolution_id"=>@api_species.evolution_id}
		# Create a new Pokemon instance containing it's traits
		@new_pokemon = Pokemon.new(@pokemon_traits)
		# Save new Pokemon to database
		@pokemon = Pokemon.save(@new_pokemon)
		@evolution_traits = {"id"=>'', "evolution_id"=>@pokemon.evolution_id, "stage1"=>@api_evolution.stage1, "stage2"=>@api_evolution.stage2,
						"stage3"=>@api_evolution.stage3}
		@new_evolutions = Evolutions.new(@evolution_traits)

		if !@new_evolutions.chain_exists?
		# Save Pokemon's evolution chain to database unless the chain exists in the database already
			@evolutions = Evolutions.save_evolution(@new_evolutions)
		else
			@evolutions = @new_evolutions
		end
		# Create new instance containing evolution table from database
		# @evolutions = Evolutions.evolution_chain(@pokemon.evolution_id)
		# Translate type ids into id names
		@type1 = @pokemon.display_type_names[0]
		@type2 = @pokemon.display_type_names[1]
	end

	erb :"pokedex/view"
end