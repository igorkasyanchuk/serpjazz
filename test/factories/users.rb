Factory.define :user, :class => User do |f|
  f.first_name { Factory.next(:first_name) }
  f.last_name { Factory.next(:last_name) }
  f.email { Factory.next(:email) }
  f.password "123456"
  f.password_confirmation "123456"
end