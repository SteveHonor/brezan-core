class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    if params[:email].present?
      client = Client.find_by(email: params[:email])
      client_id = client.id
    elsif params[:token].present?
      client = Client.find_by(token: params[:token])
      client_id = client.id
    else
      client_id = params[:client_id]
    end
    @events = Event.where(client_id: client_id)

    render json: @events
  end

  def client
    client = Client.find_by(token: params[:token])
    client_id = client.id

    @events = Event.where(client_id: client_id)

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy

      @event.albums.map do |al|
        al.photos.delete_all
      end
      @event.albums.delete_all

    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :client_id, :data)
    end
end
