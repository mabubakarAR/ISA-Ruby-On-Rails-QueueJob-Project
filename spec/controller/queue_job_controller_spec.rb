RSpec.describe QueueJobController do
    describe "GET index" do
      it "assigns @queue_jobs" do
        queue_jobs = QueueJob.create
        get :index
        expect(assigns(:queue_jobs)).to eq([queue_jobs])
      end
  
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "POST create" do
        it "create queueJob" do
            # Action to be done    
        end
    end

    describe "POST QueueJobWorker" do
        it "create Jobworker" do
            # Action to be done
        end
    end


  end