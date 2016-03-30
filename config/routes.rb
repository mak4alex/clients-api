Rails.application.routes.draw do
  namespace :api do
    resources :client,  except: [:new, :edit, :index]
    get    'clients' => 'clients#index'
    post   'clients' => 'clients#create'
    put    'clients' => 'clients#update'
    patch  'clients' => 'clients#update'
    delete 'clients' => 'clients#destroy'
  end

  get '*unmatched_route' => 'application#render_404'

end
