class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    authorize :api
    respond_with current_resource_owner
  end

  def index
    authorize :api
    users = User.where.not(id: current_resource_owner)
    respond_with(users: users)
  end
end
