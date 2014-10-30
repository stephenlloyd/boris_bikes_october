require 'docking_station'

describe DockingStation do 
	let(:station){DockingStation.new}
	let(:bike){double :bike, broken?: false, is_a?: Bike}
	let(:broken_bike){double :bike, broken?: true, :class => Bike }
	let(:van){double :van, dock: nil}

	it "can dock a bike" do
		station.dock(bike)
		expect{station.dock(bike)}.to change{station.bikes.count}.by 1
	end

	it "will only release a working bike" do
		station.dock(bike)
		expect{station.release(bike)}.to change{station.bikes.count}.by -1
	end

	it "will not release a broken bike" do 
		station.dock(broken_bike)
		station.release(broken_bike)
		expect(station.bikes).to eq [broken_bike]
	end

	it 'will no longer have broken bikes once transfered to a van' do
		station.dock(broken_bike)
		station.dock(bike)
		station.transfer_to(van)
		expect(station.bikes).to eq [bike]
	end

	it "transfers broken bikes to the van" do 
		station.dock(broken_bike)
		station.dock(bike)
		expect(van).to receive(:dock).with(broken_bike)
		station.transfer_to(van)
	end


end