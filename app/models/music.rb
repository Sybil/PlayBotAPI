class Music < ActiveRecord::Base
  self.table_name = "playbot"
  self.inheritance_column = "inheritance_type"

  has_many :tags, foreign_key: "id"
  has_one :channel, primary_key: "id", foreign_key: "content"
end
