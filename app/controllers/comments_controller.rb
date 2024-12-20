class CommentsController < ApplicationController 
    #Inherited class from application controller to manage comments on the page

    before_action :set_event #run method before execute :set_event callback
    before_action :set_comment, only: [:destroy] #run method before destroy
  
    # GET comment index from /events/:event_id/comments
    def index #def means function in ruby
      @comments = @event.comments
      render json: @comments #render in JSON format
    end
  
    # POST comment method in /events/:event_id/comments
    def create
      @comment = @event.comments.new(comment_params) #add parameters from comment_params
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE comment method in /events/:event_id/comments/:id
    def destroy
      @comment.destroy
      head :no_content
    end
  
    private #class cannot be accessible for others class
  
    def set_event # fetch event corresponding with id
      @event = Event.find(params[:event_id])
    end
  
    def set_comment # find comment and fetch in specific id
      @comment = @event.comments.find(params[:id]) 
    end
  
    def comment_params # require user name to create a comment
      params.require(:comment).permit(:content, :user_name)
    end
  end