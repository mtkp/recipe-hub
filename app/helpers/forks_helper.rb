module ForksHelper

  # cache recipe forks list with key
  def cache_key_for_forks_of(recipe)
    count = recipe.forks_count
    most_recently_updated = recipe.forks.maximum(:updated_at).utc.to_s(:number)
    "#{recipe.id}/#{count}/#{most_recently_updated}"
  end

end
