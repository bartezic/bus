ActiveAdmin.register Carrier do
  
  filter :city
  
  index do
    column :id, sortable: true
    column :name, sortable: true
    column :city, sortable: false

    default_actions
  end
end
