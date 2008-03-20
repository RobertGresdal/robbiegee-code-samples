require 'inc/connection'

#=Neuron class
#This is a new model of neurons. Now, the neurons know who are connected to
#their output (their axon), not their input, and we call upon those with
#"our" weights for those neurons. The effect is the same as before regarding
#the weights, but the system could now be considered "event driven" since 
#only the active neurons will get processing time.
#
#@see http://faculty.washington.edu/chudler/cells.html
class Neuron
	
	#* +af+ The activation function. Needs x as parameter for process
	#* +threshold+ If af is greater or equal to threshold the neuron fires
	def initialize( threshold, af )
		# an array of neurons we are connected to
		@connections =  [] 
	
		# The input value of all weights
		@weights = 0.0
		
		# Memory
		@bias = 0 
		
		# false means that we have not been triggered since we last fired (we're inactive)
		@triggerstate = false 
	
		#every triggering has a unique id, so we know that if this id is 3 and 
		# the new id is 6 we know there has been 3 triggerings in between. Every time 
		# the neuron is triggered, we need to know the trigger id so we can figure
		# out the fatigue of this neuron. High fatigue means we stop firing. That means 
		# we have a protection so a loop of neurons will not fire indefinetly
		@triggerID = 0 
		
		# The current fatigue level. If it reaches 1, the axon stops firing until
		# the fatigue has worn off
		# todo: there is no code that use the fatigue level yet
		@fatigue = 0
		
		# if the axon value reaches the fatigue limit, the fatigue increases
		# todo: there is no code that use the fatigue level yet
		@fatigueLimit = 1
		
		# The inertia of the fatigue. This means that a low inertia will cause
		# the neuron to become fatigued slower, it will also heal up faster.
		# A neuron with high inertia will keep going for longer, but will also
		# stay fatigued for longer.
		# todo: there is no code that use the fatigue level yet
		@fatigueInertia = 0.1
		
		
		if af && af.is_a(Proc) then
			@af  = af
		else
			@af = $PROC_SIGMOID;#Proc.new do |x| {1/(1+Math.exp(-x)) }# Use sigmoid as default
			#@af = af ? af : function(x){return 1/(1+Math.exp(-x))}; 
		end
		#@af = af && af.is_a(Proc) ? af : $PROC_SIGMOID
		@threshold = threshold.to_f
	end
	
	# Sigmoid math function
	$PROC_SIGMOID = Proc.new do |x|
		1/(1+Math.exp(-x))
	end
	
	# an array of neurons we are connected to
	#@connections =  [] 
	
	# Memory
	#@bias = 0 
	
	# The input value of all weights
	#@weights = 0.0
	
	# false means that we have not been triggered since we last fired (we're inactive)
	#@triggerstate = false 
	
	#every triggering has a unique id, so we know that if this id is 3 and 
	# the new id is 6 we know there has been 3 triggerings in between. Every time 
	# the neuron is triggered, we need to know the trigger id so we can figure
	# out the fatigue of this neuron. High fatigue means we stop firing. That means 
	# we have a protection so a loop of neurons will not fire indefinetly
	#@triggerID = 0 
	
	#~ # attr_accessor :af, :threshold;
	#~ # threshold.is_a?(Float)
	
	# The current fatigue level. If it reaches 1, the axon stops firing until
	# the fatigue has worn off
	#
	# todo: there is no code that use the fatigue level yet
	#@fatigue = 0
	
	# if the axon value reaches the fatigue limit, the fatigue increases
	#
	# todo: there is no code that use the fatigue level yet
	#@fatigueLimit = 1
	
	# The inertia of the fatigue. This means that a low inertia will cause
	# the neuron to become fatigued slower, it will also heal up faster.
	# A neuron with high inertia will keep going for longer, but will also
	# stay fatigued for longer.
	# 
	# todo: there is no code that use the fatigue level yet
	#@fatigueInertia = 0.1
	
	#~ #fatigueSpeed is how quickly the neuron is fatigued when the neuron
	#~ # is overloaded.
	#~ # todo: be careful how this is used currently. we'd might want to
	#~ # implement that neurons are fatigued quicker the more overloaded
	#~ # we are at the moment - this is actually highly likely so a set fatigue 
	#~ # is wrong. we'd want the acceleration or something.
	#~ #@fatigueSpeed = 1.1
	#~ # fatigue speed is a process that calculates the new fatigue based 
	#~ # on how many trigger runs before it. So if there have been 3 runs
	#~ # before and the trigger speed is 1.1**runs the fatigues value is now
	#~ # fatigue*1.331
	
	#@fatigueSpeed = Proc.new do |runs| 1.1**runs end
	
	
	
	# Calls all neurons we are connected to, telling them what our value is
	# 
	# Here also lies part of the summation function as the bias is added here
	# along with the weights, passed to the activation function and, if large
	# enough value, fire to all connected neurons.
	# 
	# * _Proc_ *register*
	# @return true if it fired, false if the threshold was not reached
	def fire(register=nil)
		@triggerstate = false # firing, remember it
		value = self.axonValue
		# fire to all connections
		if value >= @threshold then 
			#for(var i=0,end=this.connections.length;i<end;i++){
			@connections.length.times do |i|
				c = @connections[i]
				c.neuron.trigger(value*c.weight,register) # if we let the code here check the type of "neuron" to be function and call that directly, it'd save a bit of hassle getting the output. but that could be done better in the implementation of adding new neurons connections.
			end
			return true
		else
			return false
		end
	end #fire
	
	
	# Calculates and returns the axon value 
	def axonValue
		@af.call(@bias + @weights)
	end #axonValue
	

	#When this is called, that means some other neuron fired to us. 
	#The triggerstate will prevent this neuron from firing more than once each run
	# 
	#This also acts as part of the summation function, the bias being added
	#upon firing.
	#
	#* _float_ *value* The incoming value from another axon
	#* _Proc_ *register* Process to call with ourselves as argument when newly triggered
	#* _int_ *id* The triggerID so we can figure out the fatigue
	# 
	#@todo implement the fatigue
	#@todo make into valid rubycode
	def trigger( value, register, id )
		@weights += value.to_f
		if !@triggerstate && register.is_a?(Proc) then
			register.call(self)
			@triggerstate = true # we have fired this round
		end
	end #trigger
	
	
	#Represent the neuron as a string
	def to_s 
		'Value is '+self.axonValue.to_s
	end
	
	# Adds a connection to another neuron (extend the axon)
	def addConnection(weight,neuron)
		@connections.push( Connection.new(weight,neuron) )
		#@connections[@connections.length] = {'weight':weight,'neuron':neuron}
	end #addConnection
	
	#~ # TODO: implement
	#~ # think of serialization as the gene sequence :-)
	#~ def serialize
		#~ "TODO"
	#~ end
	
	#~ # TODO: implement
	#~ def unserialize serialized
		#~ self
	#~ end
	
end #Neuron