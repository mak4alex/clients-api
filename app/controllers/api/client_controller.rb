class Api::ClientController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  def show
    render json: @client
  end

  def create
    @client = Client.new(client_param)
    if @client.save
      render json: @client, status: :created, location: [ :api, @client ]
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_param)
      render json: @client, status: :ok, location: [ :api, @client ]
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    head :no_content
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_param
    params.fetch(:client, {}).permit(:id, :name, :sex, :id_number, :phone, :address)
  end

end
