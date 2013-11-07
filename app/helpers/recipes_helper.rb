module RecipesHelper

  # provide a cache key for a recipe list
  def cache_key_for_user_recipe_list(user)
    count = user.recipes.count
    most_recently_updated = user.recipes.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{user.username}/#{count}/#{most_recently_updated}"
  end

end
