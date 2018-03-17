Rails.application.routes.draw do


  devise_for :users

  get 'kbio_mhci_result/show'
  get 'kbio_mhci_result/plot'
  get 'kbio_mhci_result/plot2'
  get 'kbio_mhci_result/report'

  get 'kbio_mhcii_result/show'
  get 'kbio_mhcii_result/plot'
  get 'kbio_mhcii_result/plot2'
  get 'kbio_mhcii_result/report'

  get 'result/show'
  get 'result/plot'
  get 'result/plot2'
  get 'result/report'

  get 'mhci_result/show'
  get 'mhci_result/plot'

  get 'mhcii_result/show'
  get 'mhcii_result/plot'

  get 'jobs/show'

  resources :projects do
    resources :data
  end
  
  resources :analyses
  resources :analysis_steps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "projects#index"

end
