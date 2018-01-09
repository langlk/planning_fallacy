class Api::V1::TestController < Api::V1::ApiController
  before_action :require_login

  def index
    render json: {
      test: "This should only appear once you have logged in."
    }
  end
end
