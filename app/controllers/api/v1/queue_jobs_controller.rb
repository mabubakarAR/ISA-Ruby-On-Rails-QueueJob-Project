class Api::V1::QueueJobsController < ActionController::API

  def index
    @queue_jobs = QueueJob.all.reverse
    res_msg = @queue_jobs.present? ? "Jobs found successfully" : "No job is available in DB"
    render json: {success: true, message: res_msg, count: @queue_jobs.count, data: @queue_jobs.as_json}
  end

  def create
    @queue_job = QueueJob.new(queue_job_params)
    if @queue_job.save
        render json: {success: true, message: "Job Created Successfully", data: @queue_job.as_json}
    else
        render json: {success: false, message: @queue_job.errors.messages , data: {}}
    end
  end

  private
  def queue_job_params
    params.permit(:title, :priority)
  end

end
