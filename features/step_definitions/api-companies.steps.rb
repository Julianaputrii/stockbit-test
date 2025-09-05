require 'httparty'
require 'multi_json'
require 'json-schema'


Given('user access endpoint {string}') do |url|
  @base_url = url
end

When('user request {int} companies') do |qty|
  full_url = "#{@base_url}?_quantity=#{qty}"
  @response = HTTParty.get(full_url)
  expect(@response.code).to eq(200)
end

def company_data
  @json_data = JSON.parse(@response.body)
end

Then('verify user should receive {int} companies in the returned data') do |expect_qty_return|
  actual_qty_return = company_data['data'].length
  expect(actual_qty_return).to eq(expect_qty_return)
end

Then('verify each companies id not null') do
  companies = company_data['data']
  companies.each_with_index do |company, index|
    expect(company['id']).not_to be_nil
  end
end

And('verify the response should match the JSON schema') do
  schema_path = File.join(File.dirname(__FILE__), '../schemas/company-schema.json')
  schema = JSON.parse(File.read(schema_path))

  validate = JSON::Validator.fully_validate(schema, @json_data)
end
