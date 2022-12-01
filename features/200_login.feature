@smoke @ui @login
Feature: Login Feature

    Scenario Outline: Login <testCase> <expectedResult> <response>
        Given I am on the 'sign-in' page
        And credentials are:
            | email   | password   |
            | <email> | <password> |

        When I want to login '<testCase>'
        Then the login '<expectedResult>'
        And the response is '<response>'

        Examples:
            | testCase               | expectedResult | response                   | email              | password |
            | WITHOUT EMAIL          | FAILS          | An email address required. |                    | password |
            | WITH INVALID EMAIL     | FAILS          | Invalid email address.     | qa_email           | 12345    |
            | WITHOUT PASSWORD       | FAILS          | Password is required.      | qa_email@gmail.com |          |
            | WITH INVALID PASSWORD  | FAILS          | Invalid password.          | qa_email@gmail.com | 1234     |
            | WITH VALID CREDENTIALS | IS SUCCESSFUL  | Welcome to your account.   | qa_email@gmail.com | 12345    |