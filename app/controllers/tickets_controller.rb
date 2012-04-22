#encoding: utf-8

class TicketsController < InheritedResources::Base
  def index
    @tickets = Ticket.all

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

  def search
    @tickets = params[:commit] ? Ticket.search(params) : []
    @params = params
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @tickets }
    end
  end
end
