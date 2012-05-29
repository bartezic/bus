#encoding: utf-8

class TicketsController < InheritedResources::Base
  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def search
    @tickets = params[:commit] ? Ticket.search(params) : []
    @params = params
  end

  def reservation
    Resque.enqueue_in(2, ReserveNotification, 
      Reservation.create!(params.delete_if { |k,v| 
        ["utf8","commit","action","controller"].include?(k) 
      }).id
    ) if params[:commit]
  end

  def ticket_request
    print params
    Resque.enqueue_in(2, RequestNotification,
      Request.create!(params.delete_if { |k,v| 
        ["utf8","commit","action","controller"].include?(k) 
      }).id
    ) if params[:commit]
  end
end
