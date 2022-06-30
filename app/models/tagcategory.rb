class TagCategory < Sequel::Model(DB[:tag_category])
    one_to_many :tag, key: :category
end