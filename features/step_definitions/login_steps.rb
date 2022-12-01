
expected_result = ''

Given('credentials are:') do |table|
  @email = table.rows[0][0]
  @password = table.rows[0][1]
end

When('I want to login {string}') do |string|
  LoginPage.log_in(@email, @password)
end

Then('the login {string}') do |expected|
  expected_result = expected

  if expected_result == 'FAILS'
    assert(!LoginPage.sign_out_link, message = 'Sign in should FAILS but got SUCCESS')
  end

  if expected_result == 'IS SUCCESSFUL'
    assert(LoginPage.sign_out_link, message = "Sign in should SUCCESS but got FAIL")
  end

end

Then('the response is {string}') do |expected_msg|

  if expected_result == 'FAILS'
    actual_msgs = LoginPage.get_sign_in_errors
    assert(
      actual_msgs.include?(expected_msg), 
      message = "Expected: `#{expected_msg}` \nActual: `#{actual_msgs}`"
    )
  end

  if expected_result == 'IS SUCCESSFUL'
    actual_msg = LoginPage.get_sign_in_success_msg
    assert(
      actual_msg.include?(expected_msg), 
      message = "Expected: `#{expected_msg}` \nActual: `#{actual_msg}`"
    )
  end
 
end
