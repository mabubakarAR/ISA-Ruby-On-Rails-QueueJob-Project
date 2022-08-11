class QueueJobWorkerJob
  include Sidekiq::Job
  sidekiq_options queue: :critical

  def perform(id, title)
    movie = Movie.new(title: title)   
    job = QueueJob.find_by_id id
    if movie.save
      if job.update_attributes(status: "done")
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Updated Queue >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "
      end
    end
  end 
end
