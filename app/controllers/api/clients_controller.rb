class Api::ClientsController < ApplicationController

  def index
    clients = Client.fetch(params)
    render json: { clients: clients, meta: get_meta(clients, params) }
  end

  def create
    response = Client.create_all(clients_params)
    render json: response, status: :ok
  end


  def update
    response = Client.update_all(clients_params)
    render json: response, status: :ok
  end

  def destroy
    response = Client.delete_selected(client_ids)
    render json: response, status: :ok
  end

  private

    def client_ids
      (params[:ids] || '').split(',')
    end

    def clients_params
      params[:clients] || []
    end

end
