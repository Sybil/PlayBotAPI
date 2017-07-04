class DatabaseRedesign < ActiveRecord::Migration[5.0]

  def change
    create_table :tracks do |t|
      t.string :name
      t.string :url
      t.string :provider
      t.string :author
      t.string :channel

      t.index :name
      t.index :channel
    end

    create_table :tags do |t|
      t.string :name
      t.integer :quantity

      t.index :name
      t.index :quantity
    end

    create_join_table :tracks, :tags, table_name: :tag_assignations do |t|
      t.index :tag_id
      t.index :track_id
    end

    create_table :channels do |t|
      t.string :name
      t.integer :quantity

      t.index :name
      t.index :quantity
    end

    create_table :users do |t|
      t.string :name
      t.integer :quantity

      t.index :name
      t.index :quantity
    end

    create_table :irc_posts do |t|
      t.integer :track_id
      t.integer :channel_id
      t.integer :user_id
      t.datetime :posted_at

      t.index :track_id
      t.index :channel_id
      t.index :user_id
    end
  end
end
