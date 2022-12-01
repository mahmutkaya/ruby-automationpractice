user = User.new
address = Address.new

expected_result = ''

Given('I want to create an account with the following attributes:') do |userDt|
    userDt = userDt.hashes()

    user.email = userDt[0]['email']
    user.firstName = userDt[0]['firstName']
    user.lastName = userDt[0]['lastName']
    user.password = userDt[0]['password']
end

Given('with the following address information:') do |addressDt|
    addressDt = addressDt.hashes()
 
    address.firstName = addressDt[0]['firstName']
    address.lastName = addressDt[0]['lastName']
    address.address = addressDt[0]['address']
    address.city = addressDt[0]['city']
    address.state = addressDt[0]['state']
    address.zip = addressDt[0]['zip']
    address.country = addressDt[0]['country']
    address.mobilePhone = addressDt[0]['mobilePhone']
    address.addressAlias = addressDt[0]['addressAlias']
end

When('I save the new account {string}') do |string|
    LoginPage.sign_up(user, address)
end

Then('the save {string}') do |expected|
    expected_result = expected
end

Then('the response on ui should be: {string}') do |expected_msg|
    if expected_result == 'FAILS'
      actual_msgs = LoginPage.get_create_account_errors
      assert(
        actual_msgs.include?(expected_msg), 
        message = "Expected: `#{expected_msg}` \nActual: `#{actual_msgs}`"
      )
    end

    if expected_result == 'IS SUCCESSFUL'
      actual_msg = LoginPage.get_create_account_success_msg
      assert(
        actual_msg.include?(expected_msg), 
        message = "Expected: `#{expected_msg}` \nActual: `#{actual_msg}`"
      )
    end

end
