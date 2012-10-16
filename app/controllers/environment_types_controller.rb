class EnvironmentTypesController < ApplicationController
  # GET /environment_types
  # GET /environment_types.json
  def index
    @environment_types = EnvironmentType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @environment_types }
    end
  end

  # GET /environment_types/1
  # GET /environment_types/1.json
  def show
    @environment_type = EnvironmentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @environment_type }
    end
  end

  # GET /environment_types/new
  # GET /environment_types/new.json
  def new
    @environment_type = EnvironmentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @environment_type }
    end
  end

  # GET /environment_types/1/edit
  def edit
    @environment_type = EnvironmentType.find(params[:id])
  end

  # POST /environment_types
  # POST /environment_types.json
  def create
    @environment_type = EnvironmentType.new(params[:environment_type])

    respond_to do |format|
      if @environment_type.save
        format.html { redirect_to @environment_type, notice: 'Environment type was successfully created.' }
        format.json { render json: @environment_type, status: :created, location: @environment_type }
      else
        format.html { render action: "new" }
        format.json { render json: @environment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /environment_types/1
  # PUT /environment_types/1.json
  def update
    @environment_type = EnvironmentType.find(params[:id])

    respond_to do |format|
      if @environment_type.update_attributes(params[:environment_type])
        format.html { redirect_to @environment_type, notice: 'Environment type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @environment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environment_types/1
  # DELETE /environment_types/1.json
  def destroy
    @environment_type = EnvironmentType.find(params[:id])
    @environment_type.destroy

    respond_to do |format|
      format.html { redirect_to environment_types_url }
      format.json { head :no_content }
    end
  end
end
