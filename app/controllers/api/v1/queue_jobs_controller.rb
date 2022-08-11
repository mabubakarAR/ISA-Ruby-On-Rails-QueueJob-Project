class Api::V1::QueueJobsController < ActionController::API
  before_action :find_job, only: [:queue_job_worker]

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

  def queue_job_worker
    priority = @job_to_executed.priority
    priority = priority.parameterize.underscore.to_sym
    title = @job_to_executed.title
    job_id = QueueJobWorkerJob.set(queue: "#{priority}").perform_async(@job_to_executed.id, title)
    if @job_to_executed.status.eql?("done")
      render json: { is_success: true, error_code: 200, message: "Movie created sucessfully with job creation.", current_date_time: Time.new.strftime("%d-%m-%Y  %I:%M %p"), data: @job_to_executed.as_json }
    else
      render json: { is_success: false, error_code: 404, message: "Something went wrong please try again later.", data: {} }, status: :not_found
    end
  end

  private
  def queue_job_params
    params.permit(:title, :priority)
  end

  def find_job
      @job_to_executed = QueueJob.find_by_id params[:id]
    rescue ActiveRecord::RecordNotFound
      render json: { is_success: false, error_code: 404, message: "Queue Job not found with this ID.", data: {} }, status: :not_found
  end

end
