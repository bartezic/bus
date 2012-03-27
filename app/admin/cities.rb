ActiveAdmin.register City do
  
  filter :country
  filter :name
  
  index do
    column :name, sortable: true
    column :country, sortable: false

    default_actions
  end
end
