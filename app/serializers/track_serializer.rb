class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :type

  has_one :channel
  has_many :tags

end
