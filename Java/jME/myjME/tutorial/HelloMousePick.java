package myjME.tutorial;

import java.net.URL;

import com.jme.app.AbstractGame;
import com.jme.app.SimpleGame;
import com.jme.bounding.BoundingBox;
import com.jme.image.Texture;
import com.jme.input.AbsoluteMouse;
import com.jme.input.FirstPersonHandler;
import com.jme.input.MouseInput;
import com.jme.intersection.BoundingPickResults;
import com.jme.intersection.PickResults;
import com.jme.math.Ray;
import com.jme.math.Vector2f;
import com.jme.math.Vector3f;
import com.jme.scene.shape.Box;
import com.jme.scene.state.AlphaState;
import com.jme.scene.state.LightState;
import com.jme.scene.state.TextureState;
import com.jme.util.TextureManager;

public class HelloMousePick extends SimpleGame {
	// mouse picker
	AbsoluteMouse mouse;
	
	// this is the box in the middle
	Box b;
	
	PickResults pr;
	
	@Override
	protected void simpleInitGame() {
		// create a new mouse and restrict its movement to the screen
		mouse = new AbsoluteMouse("The mouse", display.getWidth(), 
			display.getHeight());
		
		// get a picture for the mouse
		TextureState ts = display.getRenderer().createTextureState();
		URL cursorLoc = HelloMousePick.class.getClassLoader().getResource(
			"jmetest/data/cursor/cursor1.png");
		Texture t = TextureManager.loadTexture(cursorLoc,Texture.MM_LINEAR,
			Texture.FM_LINEAR);
		ts.setTexture(t);
		mouse.setRenderState(ts);
		
		// Make the mouses background blend with what's already there
		AlphaState as = display.getRenderer().createAlphaState();
		as.setBlendEnabled(true);
		/* optional calls as far as I can see
		as.setSrcFunction(AlphaState.SB_SRC_ALPHA); // default value, so we can skip the call
		as.setDstFunction(AlphaState.DB_ONE_MINUS_SRC_ALPHA);  // default value again
		as.setTestEnabled(true); // apparently not needed here
		as.setTestFunction(AlphaState.TF_GREATER); // default is TS_ALWAYS */
		mouse.setRenderState(as);
		
		// Get the mouse input device and assign it to the AbsoluteMouse
		// Move the mouse to the middle of the screen to start with
		mouse.setLocalTranslation(new Vector3f(display.getWidth()/2,display.getHeight()/2,0));
		// assign the mouse to an input handler
		mouse.registerWithInputHandler(input);
		
		// create a box in the middle and give it bounds
		b = new Box("My box",new Vector3f(-1,-1,-1),new Vector3f(1,1,1));
		b.setModelBound(new BoundingBox());
		b.updateModelBound();

		// attach children
		rootNode.attachChild(b);
		rootNode.attachChild(mouse);
		
		// remove all the ligths so the can see the per-vertex colors
		lightState.detachAll();
		b.setLightCombineMode(LightState.OFF);
		pr = new BoundingPickResults();
		((FirstPersonHandler) input ).getMouseLookHandler().setEnabled(true);
	}
	
	protected void simpleUpdate(){
		// get the mouse from the jME mouse
		// is button 0 down? (left click)
		if(MouseInput.get().isButtonDown(0)){
			Vector2f screenPos = new Vector2f();
			// get the position the mouse is pointing to
			screenPos.set(mouse.getHotSpotPosition().x, mouse.getHotSpotPosition().y);
			// get the world location of that X,Y value
			Vector3f worldCoords = display.getWorldCoordinates(screenPos, 0);
			Vector3f worldCoords2 = display.getWorldCoordinates(screenPos, 1);
			System.out.println(worldCoords);
			// create a ray starting from the camera, and going in the direction
			// of the mouses location
			Ray mouseRay = new Ray(
				worldCoords,
				worldCoords2.subtractLocal(worldCoords).normalizeLocal()
			);
			// Does the mouses ray intersect the boxs world bounds?
			pr.clear();
			rootNode.findPick(mouseRay,pr);
			
			for(int i=0;i<pr.getNumber();i++){
				pr.getPickData(i).getTargetMesh().setRandomColors();
			}
			
		}
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloMousePick app = new HelloMousePick();
        app.setDialogBehaviour(AbstractGame.ALWAYS_SHOW_PROPS_DIALOG);
        app.start();
	}

}
