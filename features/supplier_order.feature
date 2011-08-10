# When products with drop ship suppliers are purchased, the supplier should recieve an order once a day.
# Assumes we have some products with suppliers in the database

@wip
Feature: Suppliers should have order queues
    
  In order to fulfill orders
  As a supplier
  I want to create and recieve an order queue
  
  Background:
    Given I have some products
  
  Scenario: An order is placed for a drop shippable product
    Given I have an existing supplier named "Some Big Store"
    And supplier named "Some Big Store" is linked to the first product
    And I'm placing an order for the first product
    And I'm on the order confirmation step
    Then I press "Place Order"
    And I should see "Your order has been processed successfully"
    Then supplier named "Some Big Store" should have 1 order with 1 product
    