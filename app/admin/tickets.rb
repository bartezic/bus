ActiveAdmin.register Ticket do

  controller do
    def new
      @ticket = Ticket.new
      3.times { @ticket.ways.build }

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @country }
      end
    end
  end

  form :partial => "form"
end
