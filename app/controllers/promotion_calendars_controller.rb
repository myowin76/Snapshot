class PromotionCalendarsController < ApplicationController
  # GET /promotion_calendars
  # GET /promotion_calendars.json
  layout "admin"
  def index
    @promotion_calendars = PromotionCalendar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @promotion_calendars }
    end
  end

  # GET /promotion_calendars/1
  # GET /promotion_calendars/1.json
  def show
    @promotion_calendar = PromotionCalendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @promotion_calendar }
    end
  end

  # GET /promotion_calendars/new
  # GET /promotion_calendars/new.json
  def new
    @promotion_calendar = PromotionCalendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @promotion_calendar }
    end
  end

  # GET /promotion_calendars/1/edit
  def edit
    @promotion_calendar = PromotionCalendar.find(params[:id])
  end

  # POST /promotion_calendars
  # POST /promotion_calendars.json
  def create
    @promotion_calendar = PromotionCalendar.new(params[:promotion_calendar])

    respond_to do |format|
      if @promotion_calendar.save
        format.html { redirect_to @promotion_calendar, notice: 'Promotion calendar was successfully created.' }
        format.json { render json: @promotion_calendar, status: :created, location: @promotion_calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @promotion_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /promotion_calendars/1
  # PUT /promotion_calendars/1.json
  def update
    @promotion_calendar = PromotionCalendar.find(params[:id])

    respond_to do |format|
      if @promotion_calendar.update_attributes(params[:promotion_calendar])
        format.html { redirect_to @promotion_calendar, notice: 'Promotion calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @promotion_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotion_calendars/1
  # DELETE /promotion_calendars/1.json
  def destroy
    @promotion_calendar = PromotionCalendar.find(params[:id])
    @promotion_calendar.destroy

    respond_to do |format|
      format.html { redirect_to promotion_calendars_url }
      format.json { head :no_content }
    end
  end
end
