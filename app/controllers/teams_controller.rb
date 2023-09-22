# frozen_string_literal: true

class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    render json: @team, serializer: TeamSerializer
  end
end
