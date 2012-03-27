class TicketsController < InheritedResources::Base
  def index
    @tickets = Ticket.search(params)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @tickets }
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @ticket }
    end
  end
end
