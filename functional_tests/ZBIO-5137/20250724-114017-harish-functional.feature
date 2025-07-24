Feature: Credit Card API Functional and Non-functional Testing

Background:
  Given the API base URL 'http://api.example.com'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: Fetch Credit Card Due Date and Balance
  Given a valid credit card ID '12345' exists in the system
  When I send a GET request to '/credit-cards/12345/due-balance'
  Then the response status should be 200
  And the response should contain the correct due date and balance for credit card ID '12345'

Scenario: Arrange Call for Unpaid and Overdue Balance
  Given a credit card with ID '67890' has an overdue and unpaid balance
  When I send a POST request to '/credit-cards/67890/arrange-call'
  Then the response status should be 200
  And the response should confirm that a call is arranged for the user

Scenario: Update Card Balance Post Payment
  Given a payment of $100 is processed against credit card ID '54321'
  When I send a PUT request to '/credit-cards/54321/update-balance' with payload '{ "paymentAmount": 100 }'
  Then the response status should be 200
  And the response should show that the card balance is reduced by $100 and updated correctly

Scenario: Response Time for Fetching Due Date and Balance
  Given the system is under normal load conditions
  When I send a GET request to '/credit-cards/12345/due-balance'
  Then the response status should be 200
  And the response time should be within 2 seconds

Scenario: System Behavior Under Load During Payments
  Given a high load environment with multiple payment transactions is simulated
  When I initiate multiple payment transactions concurrently
  Then all payments should be processed successfully
  And card balances should be updated accurately without any errors

Scenario: System Continuity During Payment Gateway Downtime
  Given a payment gateway downtime scenario is simulated
  When I attempt a payment transaction for credit card ID '98765'
  Then the response status should be 503
  And the system should display an error message about the gateway issue
  And ensure no data loss, recovering within a reasonable time
