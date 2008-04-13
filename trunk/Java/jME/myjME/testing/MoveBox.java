/*
 * Press U and J to move the box. 
 */

package myjME.testing;

import java.net.URL;

import myjME.tutorial.HelloKeyInput;

import com.jme.app.SimpleGame;
import com.jme.image.Texture;
import com.jme.input.KeyBindingManager;
import com.jme.input.KeyInput;
import com.jme.math.FastMath;
import com.jme.math.Quaternion;
import com.jme.math.Vector3f;
import com.jme.scene.Node;
import com.jme.scene.shape.Box;
import com.jme.scene.state.TextureState;
import com.jme.util.TextureManager;

class Ship {
	public float x,y,z;
	public float rotation;
	public Box model;
	
	public Ship(){
		x=0f;
		y=0f;
		z=0f;
		this.rotation=0f;
	}
	
	public void turn(float r){
		this.rotation += r;
	}
	
	public void thrust(float power){
		this.x += FastMath.cos(rotation) * power;
		this.y += FastMath.sin(rotation) * power;
	}
}

public class MoveBox extends SimpleGame {
	// make the ship
	//Box ship;
	
	Node n;
	Ship ship;
	Box box;
	float foo;
	
	@Override
	protected void simpleInitGame() {
		foo=0f;
		
		n = new Node("ship node");
		box = new Box("Spaceship", new Vector3f(-.5f,-.5f,-.5f), new Vector3f(.5f,.5f,.5f));
		ship = new Ship();
		
		// point to the monkey image
		URL monkeyLoc = HelloKeyInput.class.getClassLoader().
			getResource("jmetest/data/images/Monkey.jpg");
		
		// get texture state
		TextureState ts = display.getRenderer().createTextureState();
		// use TextureState to load a texture
		Texture t = TextureManager.loadTexture(monkeyLoc,
			Texture.MM_LINEAR,
			Texture.FM_LINEAR);
		// assign the texture to the TextureState
		ts.setTexture(t);
		// signal that ship should use RenderState ts
		box.setRenderState(ts);

		// attach the square to the ship node, and that to root node
		n.attachChild(box);
		rootNode.attachChild(n);
		
		// assign keys
		KeyBindingManager.getKeyBindingManager().set("moveUp",KeyInput.KEY_U);
		KeyBindingManager.getKeyBindingManager().set("moveDown",KeyInput.KEY_J);
		KeyBindingManager.getKeyBindingManager().set("rotLeft",KeyInput.KEY_H);
		KeyBindingManager.getKeyBindingManager().set("rotRight",KeyInput.KEY_K);
		
	}
	
	/*
	 * called every frame update
	 */
	protected void simpleUpdate(){
		// if the coordsUp command was activated
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("moveUp",true)){
			ship.thrust(0.02f);
		}
		// if the coordsDown was activated
		if(KeyBindingManager.getKeyBindingManager().isValidCommand("moveDown",true)){
			ship.thrust(-0.02f);
		}
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("rotLeft",true)){
			ship.turn(0.005f);
		}
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("rotRight",true)){
			ship.turn(-0.005f);
		}
		
		Quaternion q=new Quaternion();
		q.fromAngleAxis(ship.rotation,new Vector3f(0,0,1));
		
		n.setLocalTranslation(ship.x, ship.y, ship.z);
		n.setLocalRotation(q);
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		MoveBox app = new MoveBox();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}


}
