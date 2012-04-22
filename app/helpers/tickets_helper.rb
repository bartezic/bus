module TicketsHelper
  def cities_for_select
    option_groups_from_collection_for_select(Country.all, :cities, :name, :id, :name)
  end
end
