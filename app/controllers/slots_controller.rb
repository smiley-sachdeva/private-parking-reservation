class SlotsController < ApplicationController
  before_action :set_parking, only: %i[ index create show update available_slots ]
  before_action :set_slot, only: %i[ show update destroy ]
  before_action :validate_time_format, only: %i[ available_slots ], if: -> { params[:start_time].present? || params[:end_time].present? }

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

  def available_slots
    if params[:start_time].present? && params[:end_time].present?

      # Fetch available slots 
      start_date_time = timezone.parse(params[:start_time])
      end_date_time = timezone.parse(params[:end_time])

      start_time = start_date_time.utc.strftime("%H:%M:%S")
      end_time =  end_date_time.utc.strftime("%H:%M:%S")      

      # Find reservations that overlap with the given time range
      reserved_slot_ids = @parking.reservations.where('("from" < ? AND "to" > ?) OR ("from" < ? AND "to" > ?)', end_date_time, start_date_time, start_date_time, end_date_time).pluck(:slot_id)

      # Find available slots between open_time and close_time that are not reserved
      @slots = @parking.slots.where.not(id: reserved_slot_ids).where(status: 'available').where('open_time <= ? AND close_time >= ?', start_time, end_time)
      
      respond_to do |format|
        format.json { render :index, status: :ok }
      end      
    end
  end

  private
    def timezone
      ActiveSupport::TimeZone["Asia/Dubai"]
    end
    
    def validate_time_format
      start_time = params[:start_time]
      end_time = params[:end_time]

      unless start_time.present? && end_time.present?
        render json: { error: 'Start and end times are required' }, status: :unprocessable_entity
        return
      end

      unless valid_datetime?(start_time) && valid_datetime?(end_time)
        render json: { error: 'Invalid date-time format' }, status: :unprocessable_entity
      end

      unless future_datetime?(start_time) && future_datetime?(end_time)
        render json: { error: 'Start and end times must be in the future' }, status: :unprocessable_entity
      end
    end

    def valid_datetime?(datetime_str)
      DateTime.parse(datetime_str) rescue false
    end

    def future_datetime?(datetime_str)
      DateTime.parse(datetime_str) > DateTime.now rescue false
    end    

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
