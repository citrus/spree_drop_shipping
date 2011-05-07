Feature: Admin suppliers interface

  Scenario: Visiting admin suppliers index
    Given I go to the admin suppliers page
    When I follow "New Supplier"
    Then I should see "New Supplier"


  #Scenario: search
  #  Given the custom orders exist for reports feature
  #  When I fill in "search_created_at_greater_than" with "2011/01/01"
  #  When I fill in "search_created_at_less_than" with "2011/12/31"
  #  When I press "Search"
  #  Then I should see "$300.00"
