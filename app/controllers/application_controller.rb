class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        @current_user ||= User.find_by(token: token)
      end
    end

    def current_user
      return @current_user
    end

    # TODO: turn the following two methods into a policy class.
    # I like the pattern suggested in this blog:
    # http://billpatrianakos.me/blog/2013/10/22/authorize-users-based-on-roles-and-permissions-without-a-gem/
    def unauthorized_msg(msg_header)
      msg_header['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {
        error: 'You are not authorized for this action.'
      }, status: 403
    end

    def is_admin?
      return @current_user.admin?
    end
end
