module PhotosHelper
	
	def params_search
    params[:search] || params[:saved_search_id] 
  end	
	def search_country_id
    if params[:search]
      params[:search][:country_id] 
    else
       @saved_params && @saved_params['search[country_id]']
    end
  end

  def search_sectors
    if params[:search]
    	params[:search][:sectors]
    else
    	@saved_params && @saved_params['search[sectors][]']
    end
  end
  def search_retailers
  	if params[:search]
    	params[:search][:retailers]
    else
    	@saved_params && @saved_params['search[retailers][]']
    end
  end
  def search_store_formats
  	if params[:search]
    	params[:search][:sformats]
    else
    	@saved_params && @saved_params['search[sformats][]']
    end
  end
  def search_location
  	if params[:search]
    	params[:search][:location]
    else
    	@saved_params && @saved_params['search[location][]']
    end
  end
  def search_promotion_types
    if params[:search]
      params[:search][:promo_types]
    else
      @saved_params && @saved_params['search[promo_types][]']
    end
  end
  def search_promotion_calendars
    if params[:search]
      params[:search][:promo_cal]
    else
      @saved_params && @saved_params['search[promo_cal][]']
    end
  end
  def search_media_types
    if params[:search]
      params[:search][:media_type]
    else
      @saved_params && @saved_params['search[media_type][]']
    end
  end
  def search_media_vehicles
    if params[:search]
      params[:search][:media_v]
    else
      @saved_params && @saved_params['search[media_v][]']
    end
  end
  def search_media_locations
    if params[:search]
      params[:search][:media_loc]
    else
      @saved_params && @saved_params['search[media_loc][]']
    end
  end
  def search_brand_owners
    if params[:search]
      params[:search][:brand_owners]
    else
      @saved_params && @saved_params['search[brand_owners][]']
    end
  end
  def search_brands
    if params[:search]
      params[:search][:brands]
    else
      @saved_params && @saved_params['search[brands][]']
    end
  end
  def search_themes
    if params[:search]
      params[:search][:themes]
    else
      @saved_params && @saved_params['search[themes][]']
    end
  end
  def search_categories
    if params[:search]
      params[:search][:categories]
    else
      @saved_params && @saved_params['search[categories][]']
    end
  end
  def search_from_date
    if params[:search]
      params[:search][:fromDate]
    else
      @saved_params && @saved_params['search[fromDate][]']
    end
  end
  def search_to_date
    if params[:search]
      params[:search][:toDate]
    else
      @saved_params && @saved_params['search[toDate][]']
    end
  end
  def search_environment_types
    if params[:search]
      params[:search][:env_types]
    else
      @saved_params && @saved_params['search[env_types][]']
    end
  end
  def search_channels
    if params[:search]
      params[:search][:pchannel]
    else
      @saved_params && @saved_params['search[pchannel][]']
    end
  end

end
