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
    puts @tickets
    @params = params
  end

  def reservation
    Resque.enqueue_in(2, ReserveNotification, 
      Reservation.create!(params.delete_if { |k,v| 
        ["utf8","commit","action","controller"].include?(k) 
      }).id
    )
  end
end
