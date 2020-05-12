class ChangeCookTimeToNumeric < ActiveRecord::Migration

  def change
    change_column :recipes, :cook_time, :numeric
  end

end
