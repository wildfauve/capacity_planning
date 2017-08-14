module Offering

  class OfferingValue < Dry::Struct

    attribute :party, Types::Class
    attribute :service_inventory, Types::Class
    attribute :service_inventory_offering, Types::Class

  end

end
