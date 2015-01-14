lass DatabaseMigration
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence { hourly }


  def perform
    local_dump_path = 'PlayBotAPI/playbot_database_dump.sql'

    create_distant_dump
    import_dump local_dump_path
    revamp_database local_dump_path
  end

  def create_distant_dump
    dump_file = '<distant_path_of_dump_file>'
    dump_command = 'mysqldump  --single-transaction -h <mysql_info> -u <user_name> -p<password> <table_name>' 

    system("ssh <server_with_playbot_database> '#{dump_command} > #{dump_file}'")
  end

  def import_dump( local_dump_path )
    distant_dump_path = '<distant_path_of_dump_file>'

    systen("scp <server_with_playbot_database>:#{distant_dump_path} #{local_dump_path}")
  end

  def revamp_database( local_dump_path )
    ActiveRecord::Base.connection.execute(File.read(local_dump_path))
    ActiveRecord::Base.connection.execute(File.read("lib/database_migration.sql"))
  end
  
end
