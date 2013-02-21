class Admin::RolesController < ApplicationController
  # GET /admin/roles
  # GET /admin/roles.json
  def index
    @admin_roles = Admin::Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_roles }
    end
  end

  # GET /admin/roles/1
  # GET /admin/roles/1.json
  def show
    @admin_role = Admin::Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_role }
    end
  end

  # GET /admin/roles/new
  # GET /admin/roles/new.json
  def new
    @admin_role = Admin::Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_role }
    end
  end

  # GET /admin/roles/1/edit
  def edit
    @admin_role = Admin::Role.find(params[:id])
  end

  # POST /admin/roles
  # POST /admin/roles.json
  def create
    @admin_role = Admin::Role.new(params[:admin_role])

    respond_to do |format|
      if @admin_role.save
        format.html { redirect_to @admin_role, notice: 'Role was successfully created.' }
        format.json { render json: @admin_role, status: :created, location: @admin_role }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/roles/1
  # PUT /admin/roles/1.json
  def update
    @admin_role = Admin::Role.find(params[:id])

    respond_to do |format|
      if @admin_role.update_attributes(params[:admin_role])
        format.html { redirect_to @admin_role, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/roles/1
  # DELETE /admin/roles/1.json
  def destroy
    @admin_role = Admin::Role.find(params[:id])
    @admin_role.destroy

    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { head :no_content }
    end
  end
end
