require 'subdomain'

Rails.application.routes.draw do

  constraints(Subdomain.without_subdomain) do
    mount Ckeditor::Engine => '/ckeditor'
    devise_for :admin_users, path: 'cms-auth', path_names: { sign_in: 'signin', sign_out: 'signout' }

    devise_for :users,
               path_names: { sign_in: 'signin', sign_up: 'singup', sign_out: 'signout' },
               controllers: { cas_sessions: 'cas_sessions' }


    get 'sitemap' => 'site#sitemap'
    get 'feed'        => 'site#feed'

    get 'auth/twitter', as: :twitter_auth

    get 'auth/twitter/callback', to: 'twitter#create'
    delete 'auth/twitter/:id', to: 'twitter#destroy', as: :remove_twitter

    get 'admin', to: redirect('/admin/dashboard')
    namespace :admin do
      get 'dashboard' => 'dashboard#index'


      get 'weekly-digest' => 'dashboard#weekly_digest'

      resources :posts do
        get 'twitter-alerts', action: :new_twitter_alert
        put 'twitter-alerts', action: :alert_via_twitter
      end
      resources :authors
      resources :post_sections, path: 'sections'
      resources :events
      resources :email_alerts, path: 'manual-email-alerts', only: [:new, :index, :show, :destroy] do
        get 'common-settings', action: 'common_settings'
        put 'common-settings', action: 'update_common_settings'

        get 'custom-texts', action: 'custom_texts'
        put 'custom-texts', action: 'update_custom_texts'
      end

      resources :email_alert_schedules, path: 'email-alerts-schedule', only: [:index, :new, :show, :create, :update, :destroy, :edit]
      resources :pdf_email_alerts, path: 'pdf-alerts', only: [:index, :new, :create] do
        member do
          get :preview
          put 'send', action: 'send_pdf'
        end
      end

      resources :users, only: [:index, :edit, :update] do
        get 'export', action: :export, on: :collection
      end
      resources :sales_managers
      resources :graphs
      resources :pages, only: [:index, :edit, :update]
      resources :landing_pages, path: 'landing-pages'

      resources :site_settings, path: 'settings', only: [:index, :update] do
        collection do
          get :schedule
          post :schedule, action: 'save_schedule'
        end
      end
    end


    get 'euro-poll' => 'euro_poll#index'
    resources :posts, only: [:index, :show] do
      get 'section/:section_slug', action: :index, as: :section, on: :collection
      post 'mark-read', action: :mark_read, on: :member
    end

    resources :landing_pages, path: 'landing', only: [:show]
    resources :events, only: :index, path: 'euro-cal'
    resources :authors, only: [:show]
    resources :graphs, only: [:show]
    resource  :user, only: [:create, :edit, :update] do
      collection do
        post :short_create
        post :invite_request
      end
    end

    get 'search' => 'search#index', as: :search
  end
  constraints(Subdomain) do
    get '/' => 'landing_pages#show'
    get '/thanks' => 'landing_pages#thanks', as: :thanks_landing_page
  end

  constraints(Subdomain.without_subdomain) do
    root to: 'posts#index', is_home_page: true
    get ':slug' => 'pages#show', as: :page
  end
end