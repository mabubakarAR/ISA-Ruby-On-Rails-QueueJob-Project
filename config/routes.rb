Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'queue_jobs#index'

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
      resources :queue_jobs, only: %i[index create show] do
        member do
          get :queue_job_worker, to: 'queue_jobs#queue_job_worker'
        end
      end
    end
  end
  
end
