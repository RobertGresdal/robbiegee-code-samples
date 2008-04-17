package myjME.testing.game.items.vehicles;

import java.net.URL;

import com.jme.image.Texture;
import com.jme.math.FastMath;
import com.jme.math.Quaternion;
import com.jme.math.Vector3f;
import com.jme.scene.Node;
import com.jme.scene.shape.Box;
import com.jme.scene.state.TextureState;
import com.jme.system.DisplaySystem;
import com.jme.util.TextureManager;

public class SpaceShip {
	public float x,y,z,rotation;
	public Node model;
	
	private DisplaySystem display;
	
	public SpaceShip(){
		display = DisplaySystem.getDisplaySystem();
		x=0f;
		y=0f;
		z=0f;
		rotation=0f;
		
		initModel();
	}
	
	public void turn(float r){
		rotation += r;
	}
	
	public void setRotation(float r){
		rotation = r;
	}
	
	public void thrust(float power){
		this.x += FastMath.cos(rotation) * power;
		this.y += FastMath.sin(rotation) * power;
	}
	
	public void simpleUpdate(){
		Quaternion q=new Quaternion();
		q.fromAngleAxis(rotation,new Vector3f(0,0,1));
		
		model.setLocalTranslation(x, y, z);
		model.setLocalRotation(q);
	}
	
	public Node getNode(){
		return this.model;
	}
	
	private void initModel(){
		// create the model of the spaceship
		model = new Node("spaceship_node");
		Box b = new Box("spaceship",new Vector3f(-1,-1,-0.5f),new Vector3f(1,1,0.5f));
		
		// point to the monkey image
		URL monkeyLoc = SpaceShip.class.getClassLoader().
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
		b.setRenderState(ts);
		
		model.attachChild(b);
	}
}
