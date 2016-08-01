MyApp.get "/edit" do
	@all_pokemon = PokedexAll.all_pokemon
	@selected = PokedexSearch.new(params[:name], @all_pokemon)
	@pokemon = @selected.search_by_name

	erb :"pokedex/edit"
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
		# Update the selected Pokemon's information in the database
		PokedexSave.update_pokemon(@hp, @cp, @gender, @favorite, @id)
	end
	# Get all of the Pokemon from the database
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

	erb :"pokedex/view"

end

