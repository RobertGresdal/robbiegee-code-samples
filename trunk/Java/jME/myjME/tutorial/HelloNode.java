package myjME.tutorial;

import com.jme.app.SimpleGame;
import com.jme.bounding.BoundingBox;
import com.jme.bounding.BoundingSphere;
import com.jme.math.Vector3f;
import com.jme.renderer.ColorRGBA;
import com.jme.scene.Node;
import com.jme.scene.shape.Box;
import com.jme.scene.shape.Sphere;
import com.jme.scene.state.LightState;

public class HelloNode extends SimpleGame {
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloNode app = new HelloNode();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

	@Override
	protected void simpleInitGame() {
		Box b = new Box("My box",new Vector3f(0,0,0),new Vector3f(1,1,1));
		// give the box a model bounds so it can be culled
		b.setModelBound(new BoundingSphere());
		// calculate the best bounds for the object
		b.updateModelBound();
		// move the box 2 units up
		b.setLocalTranslation(0,2,0);
		// set a color
		b.setSolidColor(new ColorRGBA(1,1,0,0.5f));
		
		Sphere s = new Sphere("My sphere",20,20,1f);
		// bounds
		s.setModelBound(new BoundingBox());
		s.updateModelBound();
		// set colors
		s.setRandomColors();
		
		// create a node consisting of the box and the sphere
		Node n = new Node("My node");
		n.attachChild(b);
		n.attachChild(s);
		n.setLocalScale(5f);
		
		// remove lighting for root node so it use the colors we set
		rootNode.setLightCombineMode(LightState.OFF);
		// attach the node to the rootnode
		rootNode.attachChild(n);
	}

}
