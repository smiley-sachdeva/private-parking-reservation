class ParkingsController < ApplicationController
  before_action :set_parking, only: %i[ show edit update destroy ]

  # GET /parkings or /parkings.json
  def index
    @parkings = Parking.all
  end

  # GET /parkings/1 or /parkings/1.json
  def show
  end

  # POST /parkings or /parkings.json
  def create
    @parking = Parking.new(parking_params)
    
    respond_to do |format|
      if @parking.save
        format.json { render :show, status: :created, location: @parking }
      else
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parkings/1 or /parkings/1.json
  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.json { render :show, status: :ok, location: @parking }
      else
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parkings/1 or /parkings/1.json
  def destroy
    @parking.destroy!

    respond_to do |format|
     format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking
      @parking = Parking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parking_params
      params.require(:parking).permit(:name, :address, :open_time, :close_time)
    end
end
