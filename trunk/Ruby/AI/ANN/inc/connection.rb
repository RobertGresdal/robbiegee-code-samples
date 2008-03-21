require 'inc/neuron'

class Connection
	attr_accessor :weight, :neuron
	
	def initialize(weight, neuron)
		@weight = weight
		@neuron = neuron
	end
end
