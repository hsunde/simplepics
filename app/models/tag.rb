class Tag < Sequel::Model(DB[:tag])
    many_to_many :file, left_key: :tag, right_key: :file, join_table: :tags
    many_to_one :tag_category, key: :category
end