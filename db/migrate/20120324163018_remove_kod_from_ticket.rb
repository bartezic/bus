class RemoveKodFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :kod
  end
end
