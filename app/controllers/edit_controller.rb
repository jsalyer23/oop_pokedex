MyApp.get "/edit" do
	@pokemon = PokedexSearch.find_by_name(params[:name])
	erb :"pokedex/edit"
end

MyApp.get "/view/:id/:name" do
	if params[:id] != nil
		if @favorite == "on"
			@favorite = true
		else
			@favorite = false
		end
		# Update the selected Pokemon's information in the database
		PokedexSave.update_pokemon(params[:hp], params[:cp], params[:gender], params[:favorite], params[:id])
	end

	# Search for the Pokemon by name
	@pokemon = PokedexSearch.find_by_name(params[:name])
	@evolutions = Evolutions.evolution_chain(@pokemon.name.downcase)
	# Translate type ids into id names
	@type1 = @pokemon.display_type_names[0]
	@type2 = @pokemon.display_type_names[1]

	erb :"pokedex/view"

end

