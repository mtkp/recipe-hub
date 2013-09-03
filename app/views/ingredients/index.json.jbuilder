json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :food, :magnitude, :units, :recipe_id
  json.url ingredient_url(ingredient, format: :json)
end
