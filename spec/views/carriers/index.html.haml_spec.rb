require 'spec_helper'

describe "carriers/index" do
  before(:each) do
    assign(:carriers, [
      stub_model(Carrier,
        :name => "Name",
        :city_id => 1,
        :address => "Address",
        :phone => "Phone",
        :telephone => "Telephone",
        :fax => "Fax",
        :email => "Email",
        :web_site => "Web Site"
      ),
      stub_model(Carrier,
        :name => "Name",
        :city_id => 1,
        :address => "Address",
        :phone => "Phone",
        :telephone => "Telephone",
        :fax => "Fax",
        :email => "Email",
        :web_site => "Web Site"
      )
    ])
  end

  it "renders a list of carriers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Web Site".to_s, :count => 2
  end
end
