function MouseCursor(object){
	var x = 200;
	var y = 200;
	
	function move(e){
		p = getMousePos(e);
		setPageTopLeft(e.target);
		this.x = p[0] - object.pageLeft;
		this.y = p[1] - object.pageTop;
		opera.postError('setpos run ['+this.x+','+this.y+']');
	}
	
	function getMousePos(e){
		if( e.pageX ) {
			return [e.pageX,e.pageY]
		} else if (e.clientX) {
			x= e.clientX + document.documentElement.scrollLeft ?
				document.document.scrollLeft :
				document.body.scrollLeft;
			y= e.clientY + document.documentElement.scrollTop ?
				document.document.scrollTop :
				document.body.scrollTop;
			return [x,y];
		} else return null;
	}
	
	function setPageTopLeft( o ){
		var top = 0,
		left = 0,
		obj = o;
	 
		while ( o.offsetParent )
		 {
			 left += o.offsetLeft ;
			 top += o.offsetTop ;
			 o = o.offsetParent ;
		};
	 
		obj.pageTop = top;
		obj.pageLeft = left;
	}
	
	this.getForce = [0,0];
	this.move = move;
	this.x=x;
	this.y=y;
}

function Ball(x,y,m){
	var x,y,m;
	var vx=0,vy=0; // Force from last tick, also known as acceleration
	var forces = [];
	var loss = 0.95;
	
	// takes a vector and applies the force to this item
	//function applyForce(vector){}
	
	// the forcable item implements getForce
	function registerForce(forcable){
		forces.push(forcable);
	}
	// Summarise all forces on item
	function calculateForces(){
		//make a sum of all forces
		for(var i=0,end=forces.length;i<end;i++){
			F = forces[i].getForce();
			vx += F[0];
			vy += F[1];
		}
		vx *= loss;
		vy *= loss;
	}
	// Apply the force over dt time
	function applyForces(dt){
		this.x += vx*dt;
		this.y += vy*dt;
	}
	
	this.registerForce = registerForce;
	this.calculateForces = calculateForces;
	this.applyForces = applyForces;
	this.x = x;
	this.y = y;
	this.m = m;
}
// Anchors always sits still and never applies to any force
function Anchor(x,y){
	var x,y;
	this.applyForce = function(){};
}

/**
* @implements Forcable
*/
function Spring(p,c,l,k,C) {
	// A spring works as a doubly linked list in that
	// it knows about both it's pre and post decessor
	var p,c;
	var l; // rest length
	var k; // tension, (N/m)
	var C; // critical length of spring (will burst if extended beyond)
	var slowness = 1; // decrease this to slow everything down! cool effect
	var F; // tension force
	
	/* Hooke's lov: F = k*x; // k = fjærstivhet, x = forlengelse
    * Newton's 2. lov : F = m*a; // m = masse, a = aksellerasjon
    * l her er hvilelengden, og den trekkes fra forlengelsen
    */
	function getForce(){
		px = this.parent.x;
		py = this.parent.y;
	opera.postError(this.parent.x);
		dx = px - this.child.x;
		dy = py - this.child.y;
		d = Math.sqrt( dx*dx + dy*dy ); // distance
		F = (k*(d-l))*slowness;
		Fx = F*(dx/d);
		Fy = F*(dy/d);
		return [Fx,Fy];
	}
	this.getForce = getForce;
	this.parent = p;
	this.child = c;
}

function Gravity(){
	function getForce(){
		return [0,9.81];
	}
	this.getForce = getForce;
}

function Render(canvas){
	var balls = [];
	var strings = [];
	
	var bufferc = document.createElement('canvas');
		bufferc.setAttribute('width','480');
		bufferc.setAttribute('height','320');
	var c = bufferc.getContext('2d');
	
	var screen_canvas = canvas.getContext('2d');
		screen_canvas.globalCompositeOperation = 'copy';
	
	function registerBall(object){
		balls.push(object);
	}
	function registerString(s){
		strings.push(s);
	}
	
	function render(){
		c.clearRect(0,0,480,320);
		
		for(var i=0,end=balls.length;i<end;i++){
			c.beginPath();
			a = balls[i].m/(Math.PI*2);
			// ^- TODO: cache result somewhere
			c.arc(
				balls[i].x,
				balls[i].y,
				10*a,
				0,Math.PI*2,true
			);
			//opera.postError(balls[i].y);
			c.closePath()
			c.fill();
		}
		for(var i=0,end=strings.length;i<end;i++){
			c.beginPath();
			c.moveTo(strings[i].parent.x,strings[i].parent.y);
			c.lineTo(strings[i].child.x,strings[i].child.y);
			c.stroke();
		}
		screen_canvas.drawImage(bufferc,0,0);
	}
	
	// Make public functions
	this.render = render;
	this.registerBall = registerBall;
	this.registerString = registerString;
}

function Physics(){
	var balls = [];
	function registerBall(ball){
		balls.push(ball);
	}
	function run(t){
		var dt = t/1000;
		// veeeeeery simple physics.. no ball interaction and such cool stuff
		for(var i=0,end=balls.length;i<end;i++){
			balls[i].calculateForces(dt);
		}
		for(var i=0,end=balls.length;i<end;i++){
			balls[i].applyForces(dt);
			//opera.postError('b'+i+':['+balls[i].x+','+balls[i].y+']; ');
			// TODO: think i fixed this now:
			// 		TODO: we will get a problem here. since the balls
			// change position here, any items that relies on
			// this items position and such will get a wrong
			// calculation, so we need a calculate and then
			// apply.
		}
	}
	this.registerBall = registerBall;
	this.run = run;
}

function Logic(){
	max_tick = 6000;
	tick = 0;
	fps = 30;
	dt = Math.floor(1000/fps);
	render = null;
	physics = null;
	
	function init(){	}
	function setRender(r){
		render = r;
	}
	function setPhysics(p){
		physics = p;
	}
	
	function logic(){
		// todo input
		if(physics!=null) physics.run(dt);
		r.render();
	}
	
	function run(){
		logic();
		
		// this will repeat the run function until max_tick has been reached
		if(++tick<max_tick){
			window.setTimeout(function(){run.apply(this)},dt);
		}
		
	}
	this.setRender = setRender;
	this.setPhysics = setPhysics;
	this.run = run;
}

