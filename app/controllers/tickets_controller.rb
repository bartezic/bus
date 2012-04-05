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
    if params[:one_way].blank?
      @params = params
      @tickets = Ticket.all
    else
      @params = params
      @tickets = Ticket.search(params)
    end

    @cities_from = Country.cities_from("Україна")
    @countries_to = Country.without("Україна")
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @tickets }
    end
  end
end
