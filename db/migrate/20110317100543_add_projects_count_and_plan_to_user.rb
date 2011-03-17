class AddProjectsCountAndPlanToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :projects_count, :integer, :default => 0
    add_column :users, :plan, :string, :default => "free"
    User.update_all(:projects_count => 0, :plan => "free")
  end

  def self.down
    remove_column :users, :projects_count
    remove_column :users, :plan
  end
end
