When("I choose {string} from the {string} menu") do |subitem, item|
  within('.nav-pf-vertical-with-sub-menus') do
    click item
    within('.secondary-nav-item-pf.active') do
      click subitem
    end
  end
end

Then("I can add a new event") do
    pending # Write code here that turns the phrase above into concrete actions
end
