package myjME.tutorial;

import com.jme.app.SimpleGame;
import com.jme.scene.shape.Box;
import com.jme.math.Vector3f;

public class HelloWorld extends SimpleGame {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloWorld app = new HelloWorld(); // Create Object
		// Signal to show properties dialog
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start(); // Start the program
	}
	protected void simpleInitGame() {
		// Make a box
		Box b = new Box("Mybox", new Vector3f(0,0,0), new Vector3f(1,1,1));
		rootNode.attachChild(b); // Put it in the scene graph
	}
}
