class File_ < Sequel::Model(DB[:file])
    many_to_many :tag, left_key: :file, right_key: :tag, join_table: :tags
end