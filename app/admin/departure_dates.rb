ActiveAdmin.register DepartureDate do
  filter :day_of_life
  
  index do
    column :id, sortable: true
    column :day_of_life, sortable: true

    default_actions
  end
end
