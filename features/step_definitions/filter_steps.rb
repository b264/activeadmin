Then /^I should see a select filter for "([^"]*)"$/ do |label|
  expect(page).to have_css '.filter_select label', text: label
end

Then /^I should see a string filter for "([^"]*)"$/ do |label|
  expect(page).to have_css '.filter_string label', text: label
end

Then /^I should see a date range filter for "([^"]*)"$/ do |label|
  expect(page).to have_css '.filter_date_range label', text: label
end

Then /^I should see the following filters:$/ do |table|
  table.rows_hash.each do |label, type|
    step %{I should see a #{type} filter for "#{label}"}
  end
end

Given(/^I add parameter "([^"]*)" with value "([^"]*)" to the URL$/) do |key, value|
  separator= page.current_url.include?('?') ? '&' : '?'
  visit page.current_url + separator + key.to_s + '=' + value.to_s
end

Then(/^I should( not)? see parameter "([^"]*)" with value "([^"]*)"$/) do |negative, key, value|
  uri_with_params= page.current_url.split('?')
  
  params_string= uri_with_params.length == 2 ? uri_with_params[1] 
                                      : nil
                                     
  params= params_string != nil ? Hash[*string.split('&').collect{|i|i.split('=')}.flatten]
                               : nil
             
  if params != nill                  
    negative ? expect(params(key)).to be false 
             : expect(query_parameter_has(key)).to be true && expect(query_parameter_value(key)).to eq(value)
  end
end
