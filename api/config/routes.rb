Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      namespace :content do
        resources :repositories
        get 'repositories_with_user' => 'repositories#index_with_user'
        get 'repository_with_user/:id' => 'repositories#show_with_user'
        resources :chapters
        get 'chapters_in_repository/:id' => 'chapters#index_in_repository'
        get 'chapters_detail_in_repository/:id' => 'chapters#index_detail_in_repository'
        get 'chapter_with_repository/:id' => 'chapters#show_with_repository'
      end
      namespace :user do
        resources :users
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
