ActiveAdmin.register Country do

  filter :name

  index do
    column :name, sortable: true
    column :cities do |country|
      country.cities.map(&:name) * ', '
    end

    default_actions
  end

  show do
    attributes_table do
      row :name
      row :cities do |country|
        (country.cities.map(&:name).sort * '<br />').html_safe
      end
    end
  end
end
