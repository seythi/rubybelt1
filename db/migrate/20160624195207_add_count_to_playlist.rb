class AddCountToPlaylist < ActiveRecord::Migration
  def change
  	add_column :playlists, :count, :integer
  end
end
