Feature: Verify companies qty data, id and schema

Background:
    Given user access endpoint "https://fakerapi.it/api/v1/companies"

  Scenario Outline: Verify companies qty data returned
    When user request <numbers_of> companies
    Then verify user should receive <numbers_of> companies in the returned data

    Examples:
      | numbers_of |
      | 20         |
      | 5          |
      | 1          |

  Scenario: Verify company id & schema
      When user request 10 companies
      Then verify each companies id not null
      And verify the response should match the JSON schema

    