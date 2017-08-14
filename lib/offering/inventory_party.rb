module Offering
  class InventoryParty

    def initialize(party)
      @name = party[:name]
      @slug = party[:slug]
    end
  end
end
