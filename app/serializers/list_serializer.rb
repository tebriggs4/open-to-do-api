class ListSerializer < ActiveModel::Serializer
  attributes :user_id, :id, :title, :private
end
