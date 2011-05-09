@no-txn
Feature: Admin suppliers interface
  
  Scenario: Visiting admin suppliers index
    Given I'm on the "admin products" page
    Then I should see "Suppliers"
    When I follow "Suppliers"
  
  #Scenario: Creating a new supplier  
    #Given I go to the admin suppliers page
    #When I follow "New Supplier"
    #Then I should see "New Supplier"
