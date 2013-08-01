class SharingPreferencesController < ApplicationController
  # GET /sharing_preferences
  # GET /sharing_preferences.json
  def index
    @sharing_preferences = SharingPreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sharing_preferences }
    end
  end

  # GET /sharing_preferences/1
  # GET /sharing_preferences/1.json
  def show
    @sharing_preference = SharingPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sharing_preference }
    end
  end

  # GET /sharing_preferences/new
  # GET /sharing_preferences/new.json
  def new
    @sharing_preference = SharingPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sharing_preference }
    end
  end

  # GET /sharing_preferences/1/edit
  def edit
    @sharing_preference = SharingPreference.find(params[:id])
  end

  # POST /sharing_preferences
  # POST /sharing_preferences.json
  def create
    @sharing_preference = SharingPreference.new(params[:sharing_preference])

    respond_to do |format|
      if @sharing_preference.save
        format.html { redirect_to @sharing_preference, notice: 'Sharing preference was successfully created.' }
        format.json { render json: @sharing_preference, status: :created, location: @sharing_preference }
      else
        format.html { render action: "new" }
        format.json { render json: @sharing_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sharing_preferences/1
  # PUT /sharing_preferences/1.json
  def update
    @sharing_preference = SharingPreference.find(params[:id])

    respond_to do |format|
      if @sharing_preference.update_attributes(params[:sharing_preference])
        format.html { redirect_to @sharing_preference, notice: 'Sharing preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sharing_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sharing_preferences/1
  # DELETE /sharing_preferences/1.json
  def destroy
    @sharing_preference = SharingPreference.find(params[:id])
    @sharing_preference.destroy

    respond_to do |format|
      format.html { redirect_to sharing_preferences_url }
      format.json { head :no_content }
    end
  end
end
