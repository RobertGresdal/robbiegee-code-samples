#! /usr/bin/ruby

require 'inc/neuron'
require 'inc/net'

proc = Proc.new do |arg|
	if arg then
		puts "REQ; Was triggered with value "+arg.to_s
	else
		puts "FAIL: Was triggered, no argument given."
	end
end

proc_onfire = Proc.new do |arg|
	if arg.class == FireEvent then
		puts "PASS; onFire "+arg.to_s+"; Source = "+arg.source.to_s
	else
		puts "arg is "+arg.class.to_s
	end
end


# when you call a trigger, it register itself when calling that function
# so that is registering itself as an event for running the calucations that run
# so when triggering, the current run is the running id, so if that's the 3rd time
# we're calling all neurons, the trigger id is 3 (counting from 1: 1,2,*3*)

n1 = Neuron.new(1, Neuron::ACT_LINEAR)
n1.onFire(proc_onfire)
n1.trigger(2,proc,1)
n1.fire(proc)

#call trigger and add the function which adds it to a new array. then go
#though that array and fire them all, and add the trigger as a new array
#then repeat
##run1 = []
##n1.trigger(1,run1,1)
##n2.trigger(1,run1,1)

puts "Press <enter> to exit."
gets