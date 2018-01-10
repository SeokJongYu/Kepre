Rails.application.routes.draw do


  get 'totalanalysis' => 'static#total_analysis', as: :totalanalysis

  get 'pbs' => 'pbs#jobs'

  resources :projects do
    resources :data
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "projects#index"

end
