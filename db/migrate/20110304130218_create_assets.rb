class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.timestamps
    end
    add_column :assets, :file_file_name,    :string
    add_column :assets, :file_content_type, :string
    add_column :assets, :file_file_size,    :integer
    add_column :assets, :file_updated_at,   :datetime
  end

  def self.down
    drop_table :assets
  end
end
