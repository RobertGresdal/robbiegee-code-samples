function MouseCursor(object){
	this.x=200;
	this.y=200;
	object.addEventListener('mousemove',setPos,false);
	//object.addEventListener('mouseover',function(e){alert(this.x)},false);
	setPageTopLeft(object);
	
	function setPos(e){
		p = getMousePos(e);
		this.x = p[0] - object.pageLeft;
		this.y = p[1] - object.pageTop;
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
}

function Ball(x,y,m){
	var x,y,m;
	var vx=0,vy=0; // Force from last tick, also known as acceleration
	var forces = [];
	
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
function Spring(parent,child,l,k,F,C) {
	
	var parent,child;
	// A spring works as a doubly linked list in that
	// it knows about both it's pre and post decessor
	
	var l; // rest length
	var k; // tension, (N/m)
	var F; // tension force
	var C; // critical length of spring (will burst if extended beyond)
	
	/* Hooke's lov: F = k*x; // k = fjærstivhet, x = forlengelse
    * Newton's 2. lov : F = m*a; // m = masse, a = aksellerasjon
    * l her er hvilelengden, og den trekkes fra forlengelsen
    */
	function getForce(){
		dx = parent.x - child.x;
		dy = parent.y - child.y;
		d = Math.sqrt( dx*dx + dy*dy ); // distance
		F = (k*(d-l));
		Fx = F*(dx/d);
		Fy = F*(dy/d);
		return [Fx,Fy];
	}
	this.getForce = getForce;
}

function Gravity(){
	function getForce(){
		return [0,9.81];
	}
	this.getForce = getForce;
}

function Render(canvas){
	var balls = [];
	var bufferc = document.createElement('canvas');
		bufferc.setAttribute('width','480');
		bufferc.setAttribute('height','320');
	var c = bufferc.getContext('2d');
	
	var screen_canvas = canvas.getContext('2d');
		screen_canvas.globalCompositeOperation = 'copy';
	
	function registerBall(object,r,fill,stroke){
		balls.push(object);
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
		screen_canvas.drawImage(bufferc,0,0);
	}
	
	// Make public functions
	this.render = render;
	this.registerBall = registerBall;
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

