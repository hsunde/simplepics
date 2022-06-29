# module Admin
#     module Tags
#         def self.update_category(tag, category)
#             tag_id = DB[:tag].where(name: tag).first[:id]
#             record = DB[:tag_category].where(name: category).count
    
#             if record == 0
#                 category_id = DB[:tag_category].insert(name: category)
#             else
#                 category_id = DB[:tag_category].where(name: category).first[:id]
#             end
    
#             DB[:tag].where(id: tag_id).update(category: category_id)
#         end
#     end
# end