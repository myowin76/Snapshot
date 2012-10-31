class SaveSearchesController < ApplicationController
  # GET /save_searches
  # GET /save_searches.json
  def index
    #@save_searches = SaveSearch.all
    @save_searches = current_user.save_searches.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @save_searches }
    end
  end

  # GET /save_searches/1
  # GET /save_searches/1.json
  def show
    @save_search = SaveSearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @save_search }
    end
  end

  # GET /save_searches/new
  # GET /save_searches/new.json
  def new
    @save_search = SaveSearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      #format.json { render json: @save_search }
    end
  end

  # GET /save_searches/1/edit
  def edit
    @save_search = SaveSearch.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # POST /save_searches
  # POST /save_searches.json
  def create
    @save_search = SaveSearch.new(params[:save_search])

    respond_to do |format|
      if @save_search.save
        #format.html { redirect_to @save_search, notice: 'Save search was successfully created.' }
        format.html { redirect_to root_path, notice: 'Save search was successfull' }
        format.js
        #format.json { render json: @save_search, status: :created, location: @save_search }
      else
        format.html { render action: "new" }
        format.json { render json: @save_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /save_searches/1
  # PUT /save_searches/1.json
  def update
    @save_search = SaveSearch.find(params[:id])

    respond_to do |format|
      if @save_search.update_attributes(params[:save_search])
        format.html { redirect_to @save_search, notice: 'Save search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js
        format.json { render json: @save_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /save_searches/1
  # DELETE /save_searches/1.json
  def destroy
    @save_search = SaveSearch.find(params[:id])
    @save_search.destroy

    respond_to do |format|
      format.html { redirect_to save_searches_url }
      format.js
      format.json { head :no_content }
    end
  end
end
