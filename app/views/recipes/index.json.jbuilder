json.array!(@recipes) do |recipe|
  json.extract! recipe, :title, :notes
  json.url recipe_url(recipe, format: :json)
end
