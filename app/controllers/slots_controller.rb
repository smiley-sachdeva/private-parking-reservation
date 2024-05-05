class SlotsController < ApplicationController
  before_action :set_parking, only: %i[ index create show update ]
  before_action :set_slot, only: %i[ show update destroy ]

  # GET parkings/1/slots.json
  def index
    if params[:feature_ids].present?
      # Filter slots based on selected features
      @slots = @parking.slots.joins(:features).where(features: { id: params[:feature_ids] }).distinct
    else
      # If no feature selected, fetch all slots
      @slots = @parking.slots
    end 
  end

  # GET parkings/1/slots/1.json
  def show
  end 

  # POST parkings/1/slots.json
  def create
    @slot = @parking.slots.build(slot_params)

    # Associate the features with the slot
    @slot.feature_ids= slot_params[:feature_ids]

    respond_to do |format|
      if @slot.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1 or /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1 or /slots/1.json
  def destroy
    @slot.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_parking
      @parking = Parking.find(params[:parking_id])
    end

    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:name, :price, :open_time, :close_time, :status, feature_ids: [])
    end
end
