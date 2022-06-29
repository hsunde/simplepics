class Tag < Sequel::Model(DB[:tag])
    many_to_many :file, left_key: :tag, right_key: :file, join_table: :tags
end