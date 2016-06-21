class Api::V1::ProfilesController < ApplicationController

  before_action :doorkeeper_authorize!

  def me
    render json: current_resource_owner.to_json
  end

  def users
    users = User.where.not(id: current_resource_owner.id)
    render json: { users: users.to_json }
  end

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token 
  end
end
