class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :provider, :author, :channel

  #embed :ids, include: true

  #has_many :channels
  has_many :tags, embed: :ids, include: true
  #has_many :users

end
