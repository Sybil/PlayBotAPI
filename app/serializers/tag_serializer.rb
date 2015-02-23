class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity

  #belongs_to :track
end
