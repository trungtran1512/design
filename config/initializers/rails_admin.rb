RailsAdmin.config do |config|

  config.authorize_with :cancancan
    
  config.model Post do
    edit do
      field :title
      field :discription
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end

  config.model User do
    edit do
      field :avatar
      field :username
      field :fullname
      field :admin
      field :phone
      field :email
      field :location
    end
    show do
      field :avatar
      field :username
      field :fullname
      field :admin
      field :phone
      field :email
      field :location
      field :created_at
      field :updated_at
    end
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
  config.current_user_method { current_user }
end
