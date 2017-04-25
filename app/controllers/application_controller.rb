class ApplicationController < ActionController::Base
  include ActionController::Serialization
  protect_from_forgery with: :null_session
end
