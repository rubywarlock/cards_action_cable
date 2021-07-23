require 'sidekiq/web'

Rails.application.routes.draw do
  resources :cards

  get 'quests', to: "cards#quests"

  patch 'results', to: "cards#results", as: :quest_results

  patch 'apply', to: "cards#apply", as: :apply

  mount Sidekiq::Web => '/sidekiq'

  root to: "cards#index"
end
