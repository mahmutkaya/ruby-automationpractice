################################################################################
# Copyright 2021 spriteCloud B.V. All rights reserved.
# Generated by LapisLazuli, version 3.0.2
# Author: "mahmutkaya" <mahmutkaya.nl@gmail.com>
require 'lapis_lazuli'
require 'lapis_lazuli/cucumber'

LapisLazuli::WorldModule::Config.add_config("config/config.yml")
World(LapisLazuli)

# Do something when LapisLazuli is started (This is before the browser is opened)
LapisLazuli.Start do

  if ENV['SELENIUM_URL']
    browser :remote, {
        :url => ENV['SELENIUM_URL'],
        :caps => {
            "browser" => "Chrome"
        }
    }
  else
    # If BROWSER is NIL, Lapis Lazuli will default to Firefox
    if ENV['BROWSER'] == 'firefox'
      # Get Selenium to create a profile object
      require 'selenium-webdriver'
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['network.http.phishy-userpass-length'] = 255
      profile['network.http.use-cache'] = false

      # Start the browser with these settings
      browser :firefox, :profile => profile
    end
  end
end