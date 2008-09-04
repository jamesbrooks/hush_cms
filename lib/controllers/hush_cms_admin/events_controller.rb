class HushCmsAdmin::EventsController < HushCmsAdminController
  before_filter :find_calendar
  before_filter :find_event, :except => [ :index, :all, :new, :create ]
  
  
  def index
    @upcoming_events = true
    @events = @calendar.events.upcoming
  end
  
  def all
    @all_events = true
    @events = @calendar.events
    
    render :template => 'hush_cms_admin/events/index'
  end
  
  def show
  end
  
  def new
    @event = @calendar.events.build
  end
  
  def create
    @event = @calendar.events.build(params[:hush_cms_event])
    
    if @event.save
      redirect_to hush_cms_calendar_events_url(@calendar)
    else
      prepare_error_messages_for_javascript @event
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @event.update_attributes(params[:hush_cms_event])
      redirect_to hush_cms_calendar_events_url(@calendar)
    else
      prepare_error_messages_for_javascript @event
      render :action => 'edit'
    end
  end
  
  def destroy
    @event.destroy
    redirect_to hush_cms_admin_calendar_events_url(@calendar)
  end
  
  
private
  def find_calendar
    @calendar = HushCMS::Calendar.find(params[:calendar_id])
  end

  def find_event
    @event = @calendar.events.find(params[:id])
  end
end
