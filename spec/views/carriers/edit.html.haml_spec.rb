require 'spec_helper'

describe "carriers/edit" do
  before(:each) do
    @carrier = assign(:carrier, stub_model(Carrier,
      :name => "MyString",
      :city_id => 1,
      :address => "MyString",
      :phone => "MyString",
      :telephone => "MyString",
      :fax => "MyString",
      :email => "MyString",
      :web_site => "MyString"
    ))
  end

  it "renders the edit carrier form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => carriers_path(@carrier), :method => "post" do
      assert_select "input#carrier_name", :name => "carrier[name]"
      assert_select "input#carrier_city_id", :name => "carrier[city_id]"
      assert_select "input#carrier_address", :name => "carrier[address]"
      assert_select "input#carrier_phone", :name => "carrier[phone]"
      assert_select "input#carrier_telephone", :name => "carrier[telephone]"
      assert_select "input#carrier_fax", :name => "carrier[fax]"
      assert_select "input#carrier_email", :name => "carrier[email]"
      assert_select "input#carrier_web_site", :name => "carrier[web_site]"
    end
  end
end
