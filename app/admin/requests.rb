ActiveAdmin.register Request do
  index do
    column :id, sortable: true
    column :name
    column :city_from
    column :city_to
    column :date_from
    column :date_to
    column :created_at

    default_actions
  end  

  show do
    attributes_table do
      row :id
      row :name
      row :city_from
      row :city_to
      row :date_from
      row :date_to
      row :one_way
      row :adult
      row :child
      row :visa
      row :phone
      row :email
      row :notice
      row :created_at
    end
  end  
end
