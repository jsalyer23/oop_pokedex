MyApp.get "/view/:name" do
	if params[:name] != nil
		# Get all the Pokemon from the database
		@all_pokemon = PokedexAll.all_pokemon
		@existing = PokedexSearch.new(params[:name], @all_pokemon)
		# Search for the Pokemon by name
		@pokemon = @existing.search_by_name
		@evolutions = DatabaseEvolutions.new('', @pokemon["name"])
		# Translate type ids into id names
		@type1 = @existing.display_type_names[0]
		@type2 = @existing.display_type_names[1]
		# Translate evolution id into stage names
		@stage1 = @evolutions.stage1
		@stage2 = @evolutions.stage2
		@stage3 = @evolutions.stage3
	end

	erb :"pokedex/view"
end