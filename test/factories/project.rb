Factory.define :project, :class => Project do |f|
  f.name { Factory.next(:name) }
  f.association :user, :factory => :user
  f.domain "snap.com.ua"
  f.search_engines { |se| [se.association(:search_engine)] }
end