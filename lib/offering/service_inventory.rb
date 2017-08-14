module Offering

  class ServiceInventory

    def initialize(inventory)
      @name = inventory[:name]
      @slug = inventory[:slug]
    end
  end

end
