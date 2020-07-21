class RequestsController < ApplicationController
    before_action :set_request, only: [:show, :update, :destroy]
    before_action :authenticate_request!, only: [:create, :update, :user_requests, :index, :destroy, :map_requests]
  
    def map_requests
      @requests = Request.where(active: 1).where(status: 'unfulfilled').where.not(user_id: @current_user.id).where("(longitude <= :longone AND longitude >= :longtwo) AND (latitude <= :latone AND latitude >= :lattwo)", {longone: params[:request][:northEastLng], longtwo: params[:request][:southWestLng], latone: params[:request][:northEastLat], lattwo: params[:request][:southWestLat]}).order("created_at DESC").limit(20)
      @requests = request_user_fullname(@requests)
  
      render json: @requests
    end
  
    def count
      @requestsUnfulfilled = Request.where(active: 1).where(status: 'unfulfilled').all()
      @requestFulfilled = Request.where(active: 1).where(status: 'fulfilled').all()
      render json: { unfulfilled: @requestsUnfulfilled.count, fulfilled: @requestFulfilled.count }, status: :ok
    end
  
    def user_requests
      @requests = Request.where(user_id: @current_user.id).order("created_at DESC").limit(6)
      @requests = request_user_fullname(@requests)
      render json: @requests
    end
  
    def create
      @request = Request.new(request_params) 
      if @request.save
        render json: @request, status: :created, location: @request
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @request.update(request_params)
        render json: @request
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    end
  
    def show
      render json: @request
    end
  
    def destroy
      if @request.destroy
        render json: { message: "Deleted" }, status: :no_content
      else
        render json: { message: "Failed" }, status: :unprocessable_entity
      end
    end
  
    private
  
      def request_user_fullname (requests)
        user_ids = []
        @requests.each do |request|
          user_ids.push(request.user_id)
        end
        @requests = getUserFullName(user_ids, @requests)
      end
  
      def set_request
        @request = Request.find(params[:id])
      end
  
      def request_params
        params.require(:request).permit(:user_id, :title, :location, :latitude, :longitude, :description, :category, :status, :active, :start_count) 
      end
  end