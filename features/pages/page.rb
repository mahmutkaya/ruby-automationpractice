module Page
  extend LapisLazuli
  class << self

    def to(page)
      url = env('root') + env('pages')[page]
      browser.goto(url)
    end

  end
end