module StarsHelper

  # cache stars list with key
  def cache_key_for_stars_of(object)
    count = object.stars_count
    most_recently_updated = object.stars.maximum(:updated_at).utc.to_s(:number)
    "#{object.class.to_s.downcase}/#{object.id}/#{count}/#{most_recently_updated}"
  end

end
