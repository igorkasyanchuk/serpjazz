class CreateAssetPhotos < ActiveRecord::Migration
  def self.up
    create_table :asset_photos do |t|
      t.timestamps
    end
    add_column :asset_photos, :photo_file_name,    :string
    add_column :asset_photos, :photo_content_type, :string
    add_column :asset_photos, :photo_file_size,    :integer
    add_column :asset_photos, :photo_updated_at,   :datetime
  end

  def self.down
    drop_table :asset_photos
  end
end
