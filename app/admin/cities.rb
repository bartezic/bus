ActiveAdmin.register City do
  
  filter :country
  filter :name
  
  index do
    column :name, sortable: true
    column :country, sortable: false

    default_actions
  end

  show do
    attributes_table do
      row :name
      row :carriers do |city|
        (city.carriers.map(&:name).sort * '<br />').html_safe
      end
    end
  end
end
