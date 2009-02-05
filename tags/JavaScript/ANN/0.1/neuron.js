/**
* This is a new model of neurons. Now, the neurons know who are connected to
* their output (their axon), not their input, and we call upon those with
* "our" weights for those neurons. The effect is the same as before regarding
* the weights, but the system could now be considered "event driven" since 
* only the active neurons will get processing time.
*
* @param af - the activation function
* @see http://faculty.washington.edu/chudler/cells.html
*/
function Neuron(af,threshold) {
	this.af = af ? af : function(x){return 1/(1+Math.exp(-x))}; // Use sigmoid as default
	this.threshold = threshold!=null ? threshold : 0; // Must reach this value to fire
	
	this.connections = new Array(); // an array of neurons we are connected to
	this.bias = 0; // Memory
	this.weights = 0; // The input value of all weights
	
	
	this.triggerstate = false; // false means that we haven't been triggered since we last fired (we're inactive)
	
	/** When the fatigue has been reached, the neuron will 
	*	stop firing until it has worn off */
//	this.fatigue = 0; // the current fatigue level
//	this.fatiguelimit = 1; // if the axon value reaches this, the fatigue increases
	
	/**
	* This function is for a design pattern that allows child classes to 
	* inherit the constructor as well by calling this with it's own parameters.
	*/
	function init(af){
		if(typeof(af)=='function') this.af = af;
	}
	
	
	
	/**
	* Calls all neurons we are connected to, telling them what our value is
	*
	* Here also lies part of the summation function as the bias is added here
	* along with the weights, passed to the activation function and, if large
	* enough value, fire to all connected neurons.
	*
	* @return true if it fired, false if the threshold was not reached
	*/
	function fire(register){
		this.triggerstate = false;
		var value = this.axonValue();
		// fire to all connections
		if(value >= this.threshold){
			for(var i=0,end=this.connections.length;i<end;i++){
				var c = this.connections[i];
				c.neuron.trigger(value*c.weight,register); // if we let the code here check the type of "neuron" to be function and call that directly, it'd save a bit of hassle getting the output. but that could be done better in the implementation of adding new neurons connections.
			}
			return true;
		} else {
			return false;
		}
	}
	
	/**
	* Calculates and returns the axon value 
	*/
	function axonValue(){
		return this.af(this.bias + this.weights);
	}
	
	/**
	* When this is called, that means some other neuron fired to us. 
	* The triggerstate will prevent this neuron from firing more than once each run
	*
	* This also acts as part of the summation function, the bias being added
	* upon firing.
	*/
	function trigger(value,register){
		this.weights += value;
		if(!this.triggerstate && register && typeof(register)=='function'){
			register(this);
			this.triggerstate = true;
		}
	}
	
	/**
	* Serialize this neuron (most of it will contain the genes).
	*/
	function toString(){
		return this.axonValue();
	}
	
	/**
	* Adds a connection to another neuron
	*/
	function addConnection(weight,neuron){
		this.connections[this.connections.length] = {'weight':weight,'neuron':neuron};
	}
	
	
	
	// special purpose functions
	this.fire = fire;
	this.trigger = trigger;
	this.axonValue = axonValue;
	this.addConnection = addConnection;
	// general purpose functions
	this.init = init;
	this.toString = toString;
}



/*
function SensoryNeuron(moo){
	this.constructor(moo);
	this.type = 'SensoryNeuron';
}
SensoryNeuron.prototype = new Neuron; // inherit Neuron




function MotoryNeuron(){
	this.type = 'MotoryNeuron';
}
MotoryNeuron.prototype = new Neuron; // inherit Neuron




function InterNeuron(){
	this.type = 'InterNeuron';
}
InterNeuron.prototype = new Neuron; // inherit Neuron
*/