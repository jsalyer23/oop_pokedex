MyApp.get "/edit" do
	@all_pokemon = PokedexAll.new
	@selected = PokedexSearch.new(params[:name], @all_pokemon.all_pokemon)
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
		DATABASE.execute("UPDATE pokemon SET hp=\'#{@hp}\', cp=\'#{@cp}\', gender=\'#{@gender}\', favorite=\'#{@favorite}\' 
			WHERE id=\'#{@id}\';")
	end
	# Get all of the Pokemon from the database
	@all_pokemon = PokedexAll.new
	@existing = PokedexSearch.new(params[:name], @all_pokemon.pokemon_array)
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

