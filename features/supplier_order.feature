Feature: Supplier Drop ship orders
    
  In order to fulfill the vendor's orders
  As a supplier
  I want to receive orders for products that drop ship
  
  Background:
    Given I have some products
      And I have a shipping method
      And I have a bogus payment method
  
  Scenario: An order is placed for a drop shippable product
    Given I have an existing supplier named "Some Big Store"
      And supplier named "Some Big Store" is linked to the first product
      And I'm placing an order for the first product
      And I'm on the order confirmation step
    Then I press "Place Order"
      And I should see "Your order has been processed successfully" in the flash notice
    Then supplier named "Some Big Store" should have 1 order for the first product
      And "Some Big Store" should receive an order email
  
  Scenario: Supplier receives drop ship order
    Given I have an existing supplier named "Some Big Store"
      And supplier named "Some Big Store" has been sent a drop ship order for the first product
      And I'm logged in as "Some Big Store"
    When I follow "You must click here to confirm this order" from within the email body
    Then I should be editing the last drop ship order
      And I should see "Please review and click 'Confirm Order' to continue." in the flash notice
    When I press "Confirm Order"
    Then I should be editing the last drop ship order
      And I should see "Thanks! You've for confirming this order. Upon shipping, please click 'Process and finalize order' to continue." in the flash notice

  Scenario: Supplier ships confirmed drop ship order
    Given I have an existing supplier named "Some Big Store"
      And supplier named "Some Big Store" has been sent a drop ship order for the first product
      And I'm logged in as "Some Big Store"
      And the last drop ship order has been confirmed
      And I'm on the edit drop ship order page for the last drop ship order
    When I fill in the following:
      | Shipping method     | UPS Ground       |
      | Confirmation number | 668435154858     |
      | Tracking number     | 1Z209342093f2039 |
    When I press "Process and finalize order"
    Then I should be viewing the last drop ship order
      And I should see "Thank you for your shipment!" in the flash notice
      