@no-txn
Feature: Admin products and suppliers
  Ensures a product can be linked to a supplier
  Assumes we have some products in the database
  
  Scenario: Linking a supplier to a product
    Given I have an existing supplier named "Some Big Store"
    And I'm on the admin products page
    And I follow "Edit"
    Then I should see "Drop Shipping Supplier"
    And I select "Some Big Store" from "Drop Shipping Supplier"
    Then I press "Update"
    Then I should see "Successfully updated!"
    And "Drop Shipping Supplier" should have "Some Big Store" selected