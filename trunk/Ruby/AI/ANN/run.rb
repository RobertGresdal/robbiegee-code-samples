#! /usr/bin/ruby

require 'inc/neuron'

proc = Proc.new do |arg|
	if arg then
		puts "Was triggered and returned "+arg.to_s
	else
		puts "Was triggered. No argument given."
	end
end

n = Neuron.new( 1, nil )
#puts n
n.trigger(2,proc,1)
#n.addConnection(1, 

puts "Press <enter> to exit."
gets
