Ilove::Application.routes.draw do

  scope :api do
    resources :images, defaults: {format: :json}
  end

  get 'static/index'
  root 'static#index'
  
  # Catch-all to let Angular do the work
  get "*path" => "static#index"

end
