module Offering
  class OfferingBuilder

    include AutoInject['offering.service_inventory',
                       'offering.service_inventory_offering',
                       'offering.inventory_party',
                       'offering.offering_value'
                      ]

    def call(offering)
      to_value(build(offering))
    end

    private

    def build(offering)
      party = inventory_party.new(offering[:offering])
      inventory = service_inventory.new(offering[:inventory])
      offering = service_inventory_offering.new(party: party, inventory: inventory, offering_capacity: offering[:offering][:service_delivery_capability])
      [party, inventory, offering]
    end

    def to_value(tuple)
      offering_value.new(party: tuple[0], service_inventory: tuple[1], service_inventory_offering: tuple[2])
    end
  end
end
