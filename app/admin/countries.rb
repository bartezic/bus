ActiveAdmin.register Country do
  index do
    column :name, sortable: true
    column :cities do |country|
      country.cities.map(&:name) * ', '
    end

    default_actions
  end
end
