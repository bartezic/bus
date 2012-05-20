ActiveAdmin.register Reservation do

  index do
    column :id, sortable: true
    column :name
    column :city_from
    column :city_to
    column :departure_from do |a|
      a.departure_from.trip_number if a.departure_from
    end
    column :departure_to do |a|
      a.departure_to.trip_number if a.departure_to
    end
    column :created_at

    default_actions
  end  

  show do
    attributes_table do
      row :id
      row :name
      row :city_from
      row :city_to
      row :departure_from do |a|
        a.departure_from.trip_number if a.departure_from
      end
      row :departure_to do |a|
        a.departure_to.trip_number if a.departure_to
      end
      row :one_way
      row :adult
      row :child
      row :visa
      row :phone
      row :email
      row :created_at
    end
  end  
end
