module Offering

  class ServiceInventoryOffering
    def initialize(party:, inventory:, offering_capacity: )
      @name = offering_capacity[:name]
      @capacity_strategy = capacity_strategy_factory(offering_capacity[:capacity_strategy]).new(offering_capacity[:capacity_strategy])
    end

    private

    def capacity_strategy_factory(strategy)
      IC["offering.#{strategy[:strategy]}"]
    end
  end

end
