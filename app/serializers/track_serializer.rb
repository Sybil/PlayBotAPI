class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :type

  #embed :ids, include: true

  has_one :channel
  has_many :tags

end
