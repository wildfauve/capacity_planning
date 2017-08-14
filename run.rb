require 'pry'
require 'dry-container'
require 'dry-auto_inject'
require 'dry-struct'
require 'dry-types'
require 'dry-validation'
require 'dry-monads'

require './lib/types'

# Est milking animals is the samples.  The sample capacity is only consumed on the set up date so it doesn't matter what the sampling regime is.  For capacity we take the milking animals x 1 for the samples on the set up date.
# They weigh the two samples separately to get the litres the cow has produced and then they combine the two samples so they can test one sample in the lab

container = Dry::Container.new

container.namespace("offering") do
  register("offering_builder", -> { Offering::OfferingBuilder } )
  register("inventory_party", -> { Offering::InventoryParty } )
  register("service_inventory", -> { Offering::ServiceInventory } )
  register("service_inventory_offering", -> { Offering::ServiceInventoryOffering } )
  register("capable_to_promise", -> { Offering::CapableToPromise } )
  register("offering_value", -> { Offering::OfferingValue } )
end
container.namespace("work_order") do
  register("herd_size_strategy", -> { WorkOrder::HerdSizeStrategy } )
end

IC = container
AutoInject = Dry::AutoInject(IC)

Dir["#{Dir.pwd}/lib/**/*.rb"].each {|file| require file }

M = Dry::Monads

inventory_offering = {
          inventory: {
            slug: "herd_testing",
            name: "Herd Test"
          },
          offering: {
            slug: "lic_herd_testing",
            name: "LIC Herd Testing",
            service_delivery_capability: {
              name: "NI Herd Test",
              capacity_strategy: {
                strategy: "capable_to_promise",
                dimensions: [
                  {
                    factor: "samples",
                    weight: 1.0,
                    min: 1,
                    max: 56000,
                    concept: { type: "urn:lic:id:herd_size", strategy: IC['work_order.herd_size_strategy'] }
                  }
                ]
              }
            }
          }
        }

offering = IC["offering.offering_builder"].new.(inventory_offering)

binding.pry
