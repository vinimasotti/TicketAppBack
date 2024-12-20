class EventsController < ApplicationController
    #inherited class from application controler

    before_action :set_event, only: [:show, :update, :destroy, :buy]
    #runs before actions 

    #RESTful design
    # GET method from /events to fetch from the database
    def index
      @events = Event.all
      render json: @events
    end
  
    # GET method from /events/:id retrieveng by ID
    def show
      render json: @event
    end
  
    # POST method from /events creating a new event in JSON format
    def create
      @event = Event.new(event_params)
  
      if @event.save
        render json: @event, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT method /events/:id to update existing event
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE method /events/:id
    def destroy
      @event.destroy
      head :no_content
    end
  
    # POST method /events/:id/buy handling ticket purchase
    def buy
      if @event.remaining_tickets.nil?
        @event.remaining_tickets = @event.total_tickets
      end
  
      if @event.remaining_tickets > 0
        @event.remaining_tickets -= 1
        @event.save
        render json: { message: "Ticket purchased", remaining_tickets: @event.remaining_tickets }
      else
        render json: { error: "No tickets available" }, status: :unprocessable_entity
      end
    end
  
    private #private methods cannot be accessible for another class
  
    def set_event #fetched events based on params
      @event = Event.find(params[:id])
    end
  
    def event_params #creating rules to updating an event
      params.require(:event).permit(:name, :description, :price, :total_tickets, :remaining_tickets)
    end
  end
  