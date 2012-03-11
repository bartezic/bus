require 'spec_helper'

describe "cities/edit" do
  before(:each) do
    @city = assign(:city, stub_model(City,
      :name => "MyString",
      :country_id => 1
    ))
  end

  it "renders the edit city form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cities_path(@city), :method => "post" do
      assert_select "input#city_name", :name => "city[name]"
      assert_select "input#city_country_id", :name => "city[country_id]"
    end
  end
end
