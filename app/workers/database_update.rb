lass DatabaseUpdate
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence { hourly }

  def perform
    #TODO : Optimize update in place of rewritting all database
  end
end
