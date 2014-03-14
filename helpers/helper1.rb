# a helper method to turn a string ID
# representation into a BSON::ObjectId
def mongo_object_id val
  BSON::ObjectId.from_string(val)
end

def document_by_id id
  id = object_id(id) if String === id
  settings.mongo_db['test'].
    find_one(:_id => id).to_json
end
