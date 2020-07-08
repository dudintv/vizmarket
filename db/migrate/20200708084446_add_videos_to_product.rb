class AddVideosToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :videos, :text
    add_column :products, :youtube_ids, :text
  end
end
