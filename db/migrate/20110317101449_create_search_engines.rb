class CreateSearchEngines < ActiveRecord::Migration
  def self.up
    create_table :search_engines do |t|
      t.string :name
      t.string :domain
      t.string :short_name
    end
    create_table :projects_search_engines, :id => false do |t|
      t.string :project_id
      t.string :search_engine_id
    end
    add_index :projects_search_engines, :project_id
    add_index :projects_search_engines, :search_engine_id
    SearchEngine.create(:name => 'Google Int', :domain => 'http://google.com/', :short_name => "google")
    SearchEngine.create(:name => 'Google (Ukraine)', :domain => 'http://google.com.ua/', :short_name => "google_ua")
    SearchEngine.create(:name => 'Google (Russia)', :domain => 'http://google.ru/', :short_name => "google_ru")
  end

  def self.down
    remove_index :projects_search_engines, :project_id
    remove_index :projects_search_engines, :search_engine_id
    drop_table :projects_search_engines
    drop_table :search_engines
  end
end
