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

  def order
    UserMailer.reserve_email(params[:name],params[:email]).deliver
    ManagerMailer.reserve_email(params).deliver
  end
end
