class TagCategory < Sequel::Model(DB[:tag_category])
    one_to_many :tag, key: :category

    dataset_module do
        def by_name
            order(:name).all
        end
    end
end