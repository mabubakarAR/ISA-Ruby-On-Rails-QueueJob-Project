Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'queue_jobs#index'

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :queue_jobs, only: %i[index create show]
    end
  end
  
end
