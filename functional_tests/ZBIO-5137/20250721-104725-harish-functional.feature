Feature: क्रेडिट कार्ड API परीक्षण

Background:
  Given the API base URL 'http://api.example.com'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: क्रेडिट कार्ड की देय तिथि और शेष राशि प्राप्त करें
  Given a valid credit card number '1234-5678-9012-3456'
  When I send a GET request to '/credit-card/balance-due-date'
  Then the response status should be 200
  And the response should contain the due date and balance information

Scenario: अवैतनिक और अतिदेय शेष राशि के लिए उपयोगकर्ता को कॉल की व्यवस्था करें
  Given a credit card number '1234-5678-9012-3456' with overdue balance
  When I send a GET request to '/credit-card/check-overdue'
  Then the response status should be 200
  And the response should indicate that a call arrangement is made for the user

Scenario: भुगतान प्राप्त होने पर कार्ड शेष राशि को अपडेट करें
  Given a payment detail with amount '500' for credit card '1234-5678-9012-3456'
  When I send a POST request to '/credit-card/update-balance' with the payment details
  Then the response status should be 200
  And the response should confirm the balance is updated and the amount is deducted

Scenario: क्रेडिट कार्ड देय तिथि और शेष राशि की जानकारी प्राप्त करने के लिए प्रतिक्रिया समय का परीक्षण करें
  Given a valid credit card number '1234-5678-9012-3456'
  When I send a GET request to '/credit-card/balance-due-date'
  Then the response status should be 200
  And the response time should be within acceptable limits

Scenario: उच्च लोड के तहत कई भुगतानों के प्रसंस्करण के दौरान सिस्टम व्यवहार का परीक्षण करें
  Given multiple payment details for credit cards
  When I send a POST request to '/credit-card/process-payments' with all payment details
  Then the response status should be 200
  And the system should accurately process all payments and update all balances
