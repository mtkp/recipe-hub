class AddStarsCountToUser < ActiveRecord::Migration

  def change
    add_column :users, :stars_count, :integer, default: 0

    User.all.each do |user|
      User.update_counters(user.id, stars_count: user.stars.count)
    end
  end

end
