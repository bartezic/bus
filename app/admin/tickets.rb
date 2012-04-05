ActiveAdmin.register Ticket do

  controller do
    def new
      @ticket = Ticket.new
      @ticket.ways.build
      @ticket.departures.build
      @ticket.build_one_way_price
      @ticket.build_one_way_visa_price
      @ticket.build_two_ways_price
      @ticket.build_two_ways_visa_price
      @ticket.build_visa_price
      @ticket.build_health_insurance_price
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @country }
      end
    end

    def edit
      @ticket = Ticket.find(params[:id])
      @ticket.ways.build if @ticket.ways.empty?
      @ticket.departures.build if @ticket.departures.empty?
      @ticket.build_one_way_price unless @ticket.one_way_price
      @ticket.build_one_way_visa_price unless @ticket.one_way_visa_price
      @ticket.build_two_ways_price unless @ticket.two_ways_price
      @ticket.build_two_ways_visa_price unless @ticket.two_ways_visa_price
      @ticket.build_visa_price unless @ticket.visa_price
      @ticket.build_health_insurance_price unless @ticket.health_insurance_price
    end
  end

  index do
    column :carrier, sortable: true
    column :marshrut_from do |a|
      a.marshrut(true).html_safe
    end
    column :marshrut_to do |a|
      a.marshrut(false).html_safe
    end
    column :dates_from do |a|
      a.prt_departure_dates(true).html_safe
    end
    column :dates_to do |a|
      a.prt_departure_dates(false).html_safe
    end
    default_actions
  end

  show do
    attributes_table do
      row :carrier
      row :marshrut_from do |a|
        a.marshrut_with_detalies(true).html_safe
      end
      row :marshrut_to do |a|
        a.marshrut_with_detalies(false).html_safe
      end
      row :dates_from do |a|
        a.prt_departure_dates(true).html_safe
      end
      row :dates_to do |a|
        a.prt_departure_dates(false).html_safe
      end
    end
  end

  form :partial => "form"
end
