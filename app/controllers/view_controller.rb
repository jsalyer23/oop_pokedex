MyApp.get "/view/:name" do
	if params[:name] != nil

		@pokemon = PokedexSearch.find_by_name(params[:name])	
		@evolutions = Evolutions.evolution_chain(@pokemon.name.downcase)
		# Translate type ids into id names
		@type1 = @pokemon.display_type_names[0]
		@type2 = @pokemon.display_type_names[1]

	end

	erb :"pokedex/view"
end