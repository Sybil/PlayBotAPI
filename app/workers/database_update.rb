#TODO : Optimize update in place of rewritting all database

class DatabaseUpdate
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence { daily }

  def perform
    Rake::Task["db:seed"].invoke
  end
  
end
