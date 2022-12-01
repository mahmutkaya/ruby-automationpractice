module Helpers
  class << self

    def generate_date
      return Time.now.strftime("%m%d%H%M%S")
    end

  end
end