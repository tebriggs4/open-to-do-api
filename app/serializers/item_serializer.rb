class ItemSerializer < ActiveModel::Serializer
  attributes :list_id, :id, :name, :completed
end
