/**
* This is the neurons' environment. It contains the test of which the neuons must
* pass in order to survive.
*
* @param int num - The number of inhabitants
*/
function Environment(num){
	
	/**
	* Runs the test
	*/
	function run(callback){
		callback();
	}
	
	this.run = run;
}

