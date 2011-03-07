# http://pivotallabs.com/users/miked/blog/articles/849-parallelize-your-rspec-suite

database_configuration = YAML.load_file("#{Rails.root}/config/database.yml")

if Rails.env.test? && database_configuration['test']['database'] == ':memory:'
  puts "Connecting to in-memory database ..."
  ActiveRecord::Base.establish_connection(database_configuration['test'])
  
  puts "Building in-memory database from db/schema.rb ..."
  load "#{Rails.root}/db/schema.rb"
end
