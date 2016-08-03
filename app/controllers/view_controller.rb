MyApp.get "/view/:id" do
	if params[:id] != nil

		@pokemon = Pokedex.find(params[:id])	
		@evolutions = Evolutions.evolution_chain(@pokemon.name.downcase)
		# Translate type ids into id names
		@type1 = @pokemon.display_type_names[0]
		@type2 = @pokemon.display_type_names[1]

	end

	erb :"pokedex/view"
end