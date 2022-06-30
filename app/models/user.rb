class User < Sequel::Model(DB[:user])
	one_to_one :admin, key: :user
end

class Admin < Sequel::Model(DB[:admin])
	one_to_one :user, key: :user
end