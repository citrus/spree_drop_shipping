@no-txn
Feature: Admin suppliers interface
  
  Scenario: Visiting admin suppliers index
    Given I'm on the admin products page
    Then I should see "Suppliers" in the main menu
    When I follow "Suppliers"
    Then I should see "Listing Suppliers"
    
  Scenario: Creating a new supplier  
    Given I'm on the admin suppliers page
    When I follow "New Supplier"
    Then I should see "New Supplier"
    And I should see "Supplier Details"
    And I should see "Supplier Address"    
    When I fill in the following:
      | Name          | Some Big Store           |
      | Email         | somebigstore@example.com |
      | Phone         | 800-555-5555             |
      | URL           | somebigstore.example.com |
      | Contact       | Steve                    |
      | Contact Email | steve@example.com        |
      | Contact Phone | 555-555-5555             |
      | Address       | 100 State St             |
      | City          | Santa Barbara            |
      | Zipcode       | 93101                    |
    And I select "California" from "State"
    When I press "Create"
    Then I should see "Listing Suppliers"
    And I should see "Some Big Store"
    And I should see "successfully created" in the flash notice
  
  Scenario: Updating an existing supplier
    Given I have an existing supplier named "Some Big Store"
    And I'm on the admin suppliers page
    When I follow "Edit"
    Then I should see "Editing Supplier"
    And I should see "Supplier Details"
    And I should see "Supplier Address"
    When I fill in the following:
      | Name          | Another Big Store  |
      | Address       | 101 State St       |
    When I press "Update"
    Then I should see "Listing Suppliers"
    And I should see "Another Big Store"
    And I should see "successfully updated" in the flash notice
  
  Scenario: Deleting an existing supplier
    Given I have an existing supplier named "Some Big Store"
    And I'm on the admin suppliers page
    When I follow "Delete"
    And I wait for 1 second
    Then I should see "Are you sure?" in the popup message
    When I confirm the popup message
    Then I should but don't see "successfully removed"