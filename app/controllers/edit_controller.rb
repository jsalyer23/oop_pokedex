MyApp.get "/edit" do
	@pokemon = Pokedex.find({"id"=>params[:id]})
	erb :"pokedex/edit"
end

MyApp.get "/view/:id/:name" do
	@new_triats = {"hp"=>params[:hp], "cp"=>params[:cp], "gender"=>params[:gender], "favorite"=>params[:favorite], "id"=>params[:id]}
	# Update the selected Pokemon's information in the database
	Pokemon.update(@new_triats)
	# Search for the Pokemon by name
	@pokemon = Pokedex.find({"id"=>params[:id]})
	@evolutions = Evolutions.evolution_chain(@pokemon.evolution_id)
	# Translate type ids into id names
	@type1 = @pokemon.display_type_names[0]
	@type2 = @pokemon.display_type_names[1]

	erb :"pokedex/view"

end

