class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  # ここにincludeするだけで、すべてのコントローラに継承される。
  # このヘルパーは、helper/sessions_helper.rbに定義する。
end
