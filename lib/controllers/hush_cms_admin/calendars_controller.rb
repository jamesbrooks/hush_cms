class HushCmsAdmin::CalendarsController < HushCmsAdminController
  before_filter :find_calendars
  before_filter :find_calendar, :except => [ :index, :new, :create ]
  
  
  def index
  end
  
  def show
  end
  
  def new
    @calendar = HushCMS::Calendar.new
  end
  
  def create
    @calendar = HushCMS::Calendar.new(params[:hush_cms_calendar])
    
    if @calendar.save
      redirect_to hush_cms_admin_calendar_events_url(@calendar)
    else
      prepare_error_messages_for_javascript @calendar
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @calendar.update_attributes(params[:hush_cms_calendar])
      redirect_to hush_cms_admin_calendar_events_url(@calendar)
    else
      prepare_error_messages_for_javascript @calendar
      render :action => 'edit'
    end
  end
  
  def destroy
    @calendar.destroy
    redirect_to hush_cms_admin_calendars_url
  end
  
  
private
  def find_calendars
    @calendars = HushCMS::Calendar.find(:all)
  end

  def find_calendar
    @calendar = HushCMS::Calendar.find(params[:id])
  end
end
