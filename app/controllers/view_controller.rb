MyApp.get "/view/:id" do
	if params[:id] != nil

		@pokemon = Pokedex.find({"id"=>params[:id]})

		@evolutions = Evolutions.find("evolution_id" => @pokemon.evolution_id.to_s)
		# Translate type ids into id names
		@type1 = @pokemon.display_type_names[0]
		@type2 = @pokemon.display_type_names[1]

	end

	erb :"pokedex/view"
end