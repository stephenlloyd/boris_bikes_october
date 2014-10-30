class DockingStation

	def bikes
		@bikes
	end

	def initialize
		@bikes = []
	end

	def dock(bike)
		@bikes << bike
	end

	def release(bike)
		bikes.delete(bike) unless bike.is_a? Bike
	end

	def transfer_to(container)
		bikes.each do |bike|
			bikes.delete(bike) if bike.broken?
			container.dock(bike) if bike.broken?
		end
	end
end