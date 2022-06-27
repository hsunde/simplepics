DB = Sequel.connect('sqlite://db/sqlite.db')

unless DB.table_exists?(:file)
	DB.create_table :file do
		primary_key :id
		String :hash, {text: true, unique: true}
		String :filename, text: true
		Integer :x
		Integer :y
		Date :date, {text: true, default: Sequel::CURRENT_TIMESTAMP}
	end
end

unless DB.table_exists?(:tag_category)
	DB.create_table :tag_category do
		primary_key :id
		String :name, {text: true, unique: true}
	end

	DB[:tag_category].insert(name: 'unsorted') # default category
end

unless DB.table_exists?(:tag)
	DB.create_table :tag do
		primary_key :id
		String :name, {text: true, unique: true}
		foreign_key :category, :tag_category, :default => 1
	end

	DB[:tag].insert(name: 'image')
	DB[:tag].insert(name: 'video')
end

unless DB.table_exists?(:tags)
	DB.create_table :tags do
		primary_key :id
		foreign_key :file, :file
		foreign_key :tag, :tag
	end
end

unless DB.table_exists?(:sequences)
	DB.create_table :sequences do
		foreign_key :file, :file
		Integer :sequence
		Integer :order
		primary_key [:file, :sequence, :order]
	end
end

unless DB.table_exists?(:user)
	DB.create_table :user do
		primary_key :id
		String :username, {text: true, unique: true}
		String :email, {text: true, unique: true}
		String :password, {text: true}
	end
end

unless DB.table_exists?(:admin)
	DB.create_table :admin do
		primary_key :id
		foreign_key :user, :user
	end
end