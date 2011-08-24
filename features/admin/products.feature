@no-txn
Feature: Admin products and suppliers

  In order to tell suppliers which products were ordered
  As an admin
  I want to link products to suppliers
    
  Scenario: Linking a product to a supplier
    Given I have an existing supplier named "Some Big Store"
    And I'm on the admin products page
    Then I follow "Edit"
    And I should see "Drop Shipping Supplier"
    Then I select "Some Big Store" from "Drop Shipping Supplier"
    And I press "Update"
    Then I should see "successfully updated."
    And "Drop Shipping Supplier" should have "Some Big Store" selected
    
  Scenario: Un-Linking a product from a supplier
    Given I have an existing supplier named "Some Big Store"
    And supplier named "Some Big Store" is linked to the first product
    And I'm on the edit admin product page for the first product
    Then I should see "Drop Shipping Supplier"
    And "Drop Shipping Supplier" should have "Some Big Store" selected
    Then I select "--- none ---" from "Drop Shipping Supplier"
    And I press "Update"
    Then I should see "successfully updated."
    And "Drop Shipping Supplier" should have "" selected
    