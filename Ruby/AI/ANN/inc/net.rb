# Add neurons in here, then add connections
class NNet
	attr_reader :neurons
	attr_accessor :frames, :maxDurationLeeway
	
	def initialize 
        # Array containing all neurons in the net
		@neurons = []
		
        # ID of the current tick (a 'tick' is one processing of all neurons in net)
        @tickID = 0
		
        # Every evaluation must at least take this much time to complete. 
        # We're storing the delay, so if we're running behind we won't 
        # sleep until we've caught up. The problem with sleeping too 
        # much is if the frames is too low.
		@frames = 0.001 
        
		# maximum duration leeway, should be around 0.3 seconds so we're 
        # not going too far ahead or behind before forgiving. Default is 
        # 10 times frames time but minimum of 0.03 seconds which we're 
        # pretty sure the computer can handle
        @maxDurationLeeway = self.min(0.03,@frames*10) 
        
        @start = Time.new
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
		#~ actives = []
		#~ register = Proc.new do |neuron|
			#~ actives.push(neuron) #register the neuron (which is what will call this proc) as active
		#~ end
		
		
		# The following sequence will execute code as closely as it can to the specified
		# frames per second, evaluating twice or more before sleeping if we slept too long
		@start = Time.new
		prev_tick = @start
		delay = 0
		100.times do
			tick = Time.new
			delay += (tick-prev_tick) #todo: min( (tick-prev_tick), 0.5)
			
			if delay < @frames then
				# TODO: do a 'tick' here
				#~ sleep( @frames-delay )
                compute_nets(true, tick, prev_tick, delay) # tick
                sleep( @frames-delay )
			else 
				# TODO: do tick here, this will not be sleeped after
				compute_nets(false, tick, prev_tick, delay) # tick
			end
			delay -= @frames
			
			prev_tick = tick
		end
		puts 'Total = '+(Time.new-@start).to_s
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
    
    def compute_nets( sleeping, tick, prev_tick, delay )
        if sleeping then
            1
            #puts sprintf("foo %.8f", 123.4567)
            puts sprintf("Time: %0.9f; Delay: %0.9f; Sleeping for %0.9f", (tick-prev_tick), delay, (@frames-delay))
            #puts 'Time: '+(tick - prev_tick).to_s+'; Delay:'+delay.to_s+' (Sleeping for '+(@frames-delay).to_s+')'
        else 
            puts sprintf("Time: %0.9f; Delay: %0.9f;", (tick-prev_tick), delay)
            #puts 'Time: '+(tick - prev_tick).to_s+'; Delay:'+delay.to_s
            0
        end
    end
end