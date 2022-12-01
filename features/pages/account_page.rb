module AccountPage
  extend LapisLazuli
  class << self

    def welcome_text; browser.wait(p: { class: 'info-account' }); end
    
    def get_welcome_text
      return welcome_text.text
    end

  end
end