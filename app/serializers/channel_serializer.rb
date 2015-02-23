class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity

  #has_many :tracks
  #has_many :users
end
