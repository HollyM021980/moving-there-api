require 'pry'
module ControllerHelpers
  def sign_in(user = double('user'))
# binding.pry
    if user.nil?
      allow(request.env['HTTP_AUTHORIZATION']).to receive(:authenticate!).and_return(user)
      # allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['HTTP_AUTHORIZATION']).to receive(:authenticate!).and_return(user)
      # allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
