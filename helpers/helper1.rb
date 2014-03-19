# a helper method to turn a string ID
# representation into a BSON::ObjectId
def mongo_object_id val
  BSON::ObjectId.from_string(val)
end

def document_by_id id
  id = object_id(id) if String === id
  settings.mongo_db['test'].find_one(:_id => id).to_json
end

def delete_form object
  '<form class="form-inline" action="/triggers/' + object['_id'].to_s + '" method="POST" role="form">
    <input type="hidden" name="_method" value="DELETE">
    <button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-remove"></i></button>
  </form>'
end
