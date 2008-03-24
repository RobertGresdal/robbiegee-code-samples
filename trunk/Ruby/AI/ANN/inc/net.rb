# Add neurons in here, then add connections
class NNet
	attr_reader :neurons
	attr_accessor :frames, :maxDurationLeeway
	
	def initialize 
		@neurons = []
		@triggerID = 0
		
		@frames = 0.020 # Every evaluation must at least take this much time to complete. We're storing the delay, so if we're running behind we won't sleep until we've caught up. The problem with sleeping too much is if the frames is too low.
		@maxDurationLeeway = self.min(0.03,@frames*10) # maximum duration leeway, should be around 0.3 seconds so we're not going too far ahead or behind before forgiving. Default is 10 times frames time but minimum of 0.03 seconds which we're pretty sure the computer can handle
	end
	
	# Adds the neuron to the net and returns the index of its array position
	def add(neuron)
		@neurons.push(neuron).length-1
	end
	
    # Provides a timer and attempts to sleep the correct amount of time
    # regardless of how irratic the sleep function can be by calculating
    # several times without sleeping, then sleeping and waiting to sleep
    # again until we're running behind again. If the frames is set to 0.1
    # and larger this wouldn't really be needed, but a good frames timer
    # should probably be around 0.01 I believe. Some experimentation should
    # show us this, but unlimited is a really bad idea so we need a timer
    # and the lowest sleep we can do is too slow (around 0.05 is the least)
	def run
		start = Time.new
		
		actives = []
		register = Proc.new do |neuron|
			actives.push(neuron) #register the neuron (which is what will call this proc) as active
		end
		
		
		# The following sequence will execute code as closely as it can to the specified
		# frames per second, evaluating twice or more before sleeping if we slept too long
		frames = 0.001
		start = Time.new
		time = start
		delay = 0
		100.times do
			now = Time.new
			delay += (now-time) #todo: min( (now-time), 0.5)
			
			if delay < frames then
				# TODO: do usual stuff here
				compute_nets(true, now, time, delay)
				sleep( frames )
			else 
				# TODO: do same usual stuff here, this will not be sleeped after
				compute_nets(false, now, time, delay) #puts 'Time: '+(now - time).to_s+'; Delay:'+delay.to_s
			end
			delay -= frames
			
			time = now
		end
		puts 'Total = '+(Time.new-start).to_s
	end
	
	
	def min( n1, n2 )
		if n1 < n2 then
			return n1
		else
			return n2
		end
	end
	
	# Connect neuron1 to neuron 2 with weight
	#def connect( n1, n2, weight )
	
    
    private # All methods below are private methods
    
    def compute_nets( sleeping, now, time, delay )
        if sleeping then
            1
            #puts 'Time: '+(now - time).to_s+'; Delay:'+delay.to_s+' (Sleeping)'
        else 
            #puts 'Time: '+(now - time).to_s+'; Delay:'+delay.to_s
            0
        end
    end
end