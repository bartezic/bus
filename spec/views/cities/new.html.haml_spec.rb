require 'spec_helper'

describe "cities/new" do
  before(:each) do
    assign(:city, stub_model(City,
      :name => "MyString",
      :country_id => 1
    ).as_new_record)
  end

  it "renders new city form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cities_path, :method => "post" do
      assert_select "input#city_name", :name => "city[name]"
      assert_select "input#city_country_id", :name => "city[country_id]"
    end
  end
end
