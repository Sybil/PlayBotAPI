class Music < ActiveRecord::Base
  self.table_name = "playbot"
  self.inheritance_column = "inheritance_type"
end
