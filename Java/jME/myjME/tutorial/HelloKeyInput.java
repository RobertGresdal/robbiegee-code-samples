package myjME.tutorial;

import java.net.URL;
import java.nio.FloatBuffer;

import com.jme.app.SimpleGame;
import com.jme.image.Texture;
import com.jme.input.KeyBindingManager;
import com.jme.input.KeyInput;
import com.jme.math.Vector2f;
import com.jme.math.Vector3f;
import com.jme.scene.TriMesh;
import com.jme.scene.state.TextureState;
import com.jme.util.TextureManager;
import com.jme.util.geom.BufferUtils;

public class HelloKeyInput extends SimpleGame {
	// the TriMesh i will change
	TriMesh square;
	// a scale of my current texture values
	float coordDelta;
	
	@Override
	protected void simpleInitGame() {
		Vector3f[] vertexes = {
			new Vector3f(0,0,0),
			new Vector3f(1,0,0),
			new Vector3f(0,1,0),
			new Vector3f(1,1,0)
		};
		//texture coordinates for each position
		coordDelta = 1;
		Vector2f[] texCoords = {
			new Vector2f(0,0),
			new Vector2f(coordDelta,0),
			new Vector2f(0,coordDelta),
			new Vector2f(coordDelta,coordDelta)
		};
		// indexes of vertex/normal/color/texCoord sets
		int[] indexes = {
			0,1,2,1,3,2
		};
		
		// create the square
		square = new TriMesh("My mesh",
			BufferUtils.createFloatBuffer(vertexes),
			null,
			null,
			BufferUtils.createFloatBuffer(texCoords),
			BufferUtils.createIntBuffer(indexes)
		);
		
		// point to the monkey image
		URL monkeyLoc = HelloKeyInput.class.getClassLoader().
			getResource("jmetest/data/images/Monkey.jpg");
		
		// get my texture state
		TextureState ts = display.getRenderer().createTextureState();
		// get my texure
		Texture t = TextureManager.loadTexture(monkeyLoc,
			Texture.MM_LINEAR,
			Texture.FM_LINEAR);
		// set a wrap for my texture so it repeats
		t.setWrap(Texture.WM_WRAP_S_WRAP_T);
		
		// set the texture to the TextureState
		ts.setTexture(t);
		// assign the texturestate to the square
		square.setRenderState(ts);
		// scale the square 10x larger
		square.setLocalScale(10);

		// attach the square to the root node
		rootNode.attachChild(square);
		
		// assign keys
		KeyBindingManager.getKeyBindingManager().set("coordsUp",KeyInput.KEY_ADD);
		KeyBindingManager.getKeyBindingManager().set("coordsUp",KeyInput.KEY_U);
		KeyBindingManager.getKeyBindingManager().set("coordsDown",KeyInput.KEY_SUBTRACT);
	}
	
	/*
	 * called every frame update
	 */
	protected void simpleUpdate(){
		// if the coordsDown was activated
		if(KeyBindingManager.getKeyBindingManager().isValidCommand("coordsDown",true)){
			// scale my texture down
			coordDelta -= .01f;
			// get my squares texture array
			FloatBuffer stBuffer = square.getTextureBuffer(0,0);
			// change the values of the texture array
			stBuffer.put(2, coordDelta);
			stBuffer.put(5, coordDelta);
			stBuffer.put(6, coordDelta);
			stBuffer.put(7, coordDelta);
			// the textures are updated
		}
		// if the coordsUp command was activated
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("coordsUp",true)){
			// Scale my texture up
			coordDelta+=.01f;
			// Assign each texture value manually.
			FloatBuffer	stBuffer = square.getTextureBuffer(0, 0);
			// Change the values of the texture array
			stBuffer.put(2, coordDelta);  
			stBuffer.put(5, coordDelta);
			stBuffer.put(6, coordDelta);
			stBuffer.put(7, coordDelta);
			// The texture coordinates are updated
		}
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloKeyInput app = new HelloKeyInput();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

}
