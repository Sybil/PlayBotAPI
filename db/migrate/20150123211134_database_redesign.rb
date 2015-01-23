class DatabaseRedesign < ActiveRecord::Migration

  def change
    create_table :tracks do |t|
      t.text :name
      t.text :url
      t.text :provider
      t.text :author
      t.text :channel
    end

    create_table :tags do |t|
      t.text :name
      t.integer :quantity
    end

    create_join_table :tracks, :tags, table_name: :tag_assignations

    create_table :channels do |t|
      t.text :name
      t.integer :quantity
    end

    create_table :users do |t|
      t.text :name
      t.integer :quantity
    end

    create_table :irc_posts do |t|
      t.integer :track_id
      t.integer :channel_id
      t.integer :user_id
      t.datetime :posted_at
    end

    #ActiveRecord::Base.connection.execute("
    #  create view tracks_view AS
    #    SELECT * FROM tracks
    #    LEFT JOIN irc_posts
    #      ON tracks.id = irc_posts.track_id
    #        LEFT JOIN channels
    #          ON irc_posts.channel_id = channels.id
    #        LEFT JOIN users
    #          ON irc_posts.user_id = users.id
    #")
  end  

end
