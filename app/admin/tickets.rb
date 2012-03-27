ActiveAdmin.register Ticket do

  controller do
    def new
      @ticket = Ticket.new
      @ticket.ways.build
      @ticket.departures.build
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @country }
      end
    end
  end

  index do
    column :carrier, sortable: true
    column :cities_from_ukr
    column :cities_to_ukr
    column :departure_dates_from_ukr
    column :departure_dates_to_ukr

    default_actions
  end

  show do
    attributes_table do
      row :carrier
      row :cities_from_ukr_detalies do |a|
        a.cities_from_ukr_detalies.html_safe
      end
      row :cities_to_ukr_detalies do |a|
        a.cities_to_ukr_detalies.html_safe
      end
      row :departure_dates_from_ukr do |a|
        a.departure_dates_from_ukr.html_safe
      end
      row :departure_dates_to_ukr do |a|
        a.departure_dates_to_ukr.html_safe
      end
    end
  end

  form :partial => "form"
end
