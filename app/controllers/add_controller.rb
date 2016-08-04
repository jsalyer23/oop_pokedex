MyApp.get "/add" do
	@title = "Add New Pok&eacute;mon"
	erb :"pokedex/add"
end

MyApp.get "/view" do
	@title = "Add New Pok&eacute;mon"
	# Check if the Pokemon being added already exists
	@search = Pokedex.search(params[:name])
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
		# Create a new Pokemon instance containing it's traits
		@new_pokemon = Pokemon.new('', @api_data.id, params[:name].capitalize, @api_data.height, @api_data.weight, params[:gender],
									 @favorite, params[:hp], params[:cp], @api_evolution.evolves?, @types_ids[0], @types_ids[1])
		# Save new Pokemon to database
		@pokemon = Pokemon.save(@new_pokemon)
		# Save Pokemon's evolution chain to database unless the chain exists in the database already
		Evolutions.save_evolution(@api_evolution.evolutions, @api_species.evolution_id)
		# Create new instance containing evolution table from database
		@evolutions = Evolutions.evolution_chain(@pokemon.name.downcase)
		# Translate type ids into id names
		@type1 = @pokemon.display_type_names[0]
		@type2 = @pokemon.display_type_names[1]
	end

	erb :"pokedex/view"
end