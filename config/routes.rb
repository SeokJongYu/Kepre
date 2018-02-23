Rails.application.routes.draw do


  devise_for :users
  get 'mhcii_result/show'

  get 'mhcii_result/plot'

  get 'kbio_mhci_result/show'
  get 'kbio_mhci_result/plot'

  get 'result/show'
  get 'result/plot'

  get 'mhci_result/show'
  get 'mhci_result/plot'

  get 'totalanalysis' => 'static#total_analysis', as: :totalanalysis

  get 'pbs' => 'pbs#jobs'

  resources :projects do
    resources :data
  end
  
  resources :analyses
  resources :analysis_steps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "projects#index"

end
