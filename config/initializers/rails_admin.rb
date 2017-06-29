RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true
  config.included_models = %w[Account Material Product License Metadata Doorkeeper::Application]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Account' do
    edit do
      exclude_fields :created_at, :updated_at
    end
  end

  config.model 'Metadata' do
    edit do
      exclude_fields :created_at, :updated_at
    end
  end

  config.model 'Doorkeeper::Application' do
    create do
      exclude_fields :uid, :secret, :created_at, :updated_at
    end
  end

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      if ENV['RAILS_ADMIN_LOGIN'].present? && ENV['RAILS_ADMIN_PASSWORD'].present?
        username == ENV['RAILS_ADMIN_LOGIN'] && password == ENV['RAILS_ADMIN_PASSWORD']
      else
        false
      end
    end
  end
end
