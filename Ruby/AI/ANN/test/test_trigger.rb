#! /usr/bin/ruby

require 'inc/neuron'
require 'inc/net'

$trigger = false

teststep = Proc.new do |arg|
	if arg then
		if arg.to_f == 1.0 then
			puts 'PASS (step)'
		else
			puts 'FAIL (step) reason: value expected 1.0, got '+arg.to_s+arg.class.to_s
		end
	else
		puts "FAIL (step) reason: No argument given on trigger"
	end
	$trigger = true
end

testlinear = Proc.new do |arg|
	if arg then
		if arg.to_f == 2.0 then
			puts 'PASS (linear)'
		else
			puts 'FAIL (linear) reason: value expected 2.0, got '+arg.to_s
		end
	else
		puts "FAIL (linear) reason: No argument given on trigger"
	end
	$trigger = true
end

testsigmoid = Proc.new do |arg|
	if arg then
		if arg.to_f > 0.880 && arg.to_f < 0.881 then
			puts 'PASS (sigmoid)'
		else
			puts 'FAIL (sigmoid) reason: value expected 0.880797077977882, got '+arg.to_s
		end
	else
		puts "FAIL (sigmoid) reason: No argument given on trigger"
	end
	$trigger = true
end


n1 = Neuron.new(1, Neuron::ACT_STEP)
n1.trigger(2,teststep,1)
if not $trigger then
	puts 'FAIL (step) reason: proc not called'
end
$trigger = false



n1 = Neuron.new(1, Neuron::ACT_LINEAR)
n1.trigger(2,testlinear,1)
if not $trigger then
	puts 'FAIL (linear) reason: proc not called'
end
$trigger = false



n1 = Neuron.new(1, Neuron::ACT_SIGMOID)
n1.trigger(2,testsigmoid,1)
if not $trigger then
	puts 'FAIL (sigmoid) reason: proc not called'
end
$trigger = false



puts "Press <enter> to exit."
gets