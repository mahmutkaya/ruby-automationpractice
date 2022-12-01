module LoginPage
  extend LapisLazuli
  class << self

    # @formatter:off
    def sign_in_link; browser.wait(a: { text: 'Sign in' }); end
    def sign_out_link; browser.wait(a: { text: 'Sign out' }, timeout: 5, throw: false); end

    # ------- sign in ------- #
    def email_input; browser.wait(input: { id: 'email' }); end
    def password_input; browser.wait(input: { id: 'passwd' }); end
    def submit_login_btn; browser.wait(button: { id: 'SubmitLogin' }); end

    # ------- sign up ------- #
    def emailCreateInput; browser.wait(input: { id: 'email_create' }, timeout: 5, throw: false); end
    def submitCreateBtn; browser.wait(button: { id: 'SubmitCreate' }); end

    def submitEmailErrorList
      browser.wait_all(:xpath => '//div[@id="create_account_error"]//li')
    end
    def createAccountErrorList
      browser.wait_all(:xpath => '//div[@class="alert alert-danger"]//li')
    end

    def personalInfoHeader; browser.wait(h3: { text: 'Your personal information' }, timeout: 5, throw: false); end
    def registerBtn; browser.wait(button: { id: 'submitAccount' }); end

    # personal info
    def firstNameInput_PI; browser.wait(input: { id: 'customer_firstname' }); end
    def lastNameInput_PI; browser.wait(input: { id: 'customer_lastname' }); end
    def passwordInput_PI; browser.wait(input: { id: 'passwd' }); end

    # address info
    def firstNameInput_AI; browser.wait(input: { id: 'firstname' }); end
    def lastNameInput_AI; browser.wait(input: { id: 'lastname' }); end
    def address1Input_AI; browser.wait(input: { id: 'address1' }); end
    def cityInput_AI; browser.wait(input: { id: 'city' }); end
    def stateSelect_AI; browser.select(id: 'id_state'); end
    def postCodeInput_AI; browser.wait(input: { id: 'postcode' }); end
    def countrySelect_AI; browser.select(id: 'id_country'); end
    def mobilePhoneInput_AI; browser.wait(input: { id: 'phone_mobile' }); end
    def aliasInput_AI; browser.wait(input: { id: 'alias' }); end
    # @formatter:on

    
    def log_in(email, password)
      email_input.to_subtype.set(email)
      password_input.to_subtype.set(password)
      submit_login_btn.click
    end

    def sign_up(user, address)
      submit_email(user)
      # check the current page and call registerAccount() method
      # to fill out personal info part
      if personalInfoHeader
        register_account(user, address);
      end

    end

    private def submit_email(user)
      # generate email ** we would not need this if we could delete account
      email = ""

      if !user.email.to_s.strip.empty?
        email = user.email;
        # to test signup with existing email don't generate a new one
        if !user.email.include? "exist"
          iend = email.rindex('_')+1;
          email = email[0, iend] + Helpers.generate_date + email[iend..];
        end
      end

      emailCreateInput.to_subtype.set(email);
      submitCreateBtn.click;
    end

    private def register_account(user, address)
      # enter personal infos
      firstNameInput_PI.to_subtype.set user.firstName
      lastNameInput_PI.to_subtype.set user.lastName
      passwordInput_PI.to_subtype.set user.password

      # enter address infos
      firstNameInput_AI.to_subtype.set address.firstName
      lastNameInput_AI.to_subtype.set address.lastName
      address1Input_AI.to_subtype.set address.address
      cityInput_AI.to_subtype.set address.city

      stateSelect_AI.select address.state

      postCodeInput_AI.to_subtype.set address.zip

      countrySelect_AI.select address.country

      mobilePhoneInput_AI.to_subtype.set address.mobilePhone
      aliasInput_AI.to_subtype.set address.addressAlias

      registerBtn.click
    end

    def get_create_account_errors
      errorLs = []
      if emailCreateInput
        submitEmailErrorList.each do |el|
          errorLs.push el.text
        end
      end

      if personalInfoHeader
        createAccountErrorList.each do |el|
          errorLs.push el.text
        end
      end

      return errorLs
    end

    def get_create_account_success_msg
      msg = ''

      if personalInfoHeader
        msg = personalInfoHeader.text
      end

      if is_my_account_page
        msg = AccountPage.get_welcome_text
      end

      return msg
    end

    def get_sign_in_errors
      errorLs = []
      # sign in and create account page are using same same alert locator
      createAccountErrorList.each do |el|
        errorLs.push el.text
      end

      return errorLs
    end

    def get_sign_in_success_msg
      return AccountPage.get_welcome_text
    end

    private def is_my_account_page; browser.url == 'controller=my-account'; end

  end
end
