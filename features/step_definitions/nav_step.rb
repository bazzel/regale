When("I choose {string} from the {string} menu") do |subitem, item|
  within('.nav-pf-vertical-with-sub-menus') do
    click_on item
    within('.secondary-nav-item-pf', text: item) do
      click_on subitem
    end
  end
end
