package myjME.tutorial;

import java.net.URL;

import com.jme.app.SimpleGame;
import com.jme.bounding.BoundingBox;
import com.jme.bounding.BoundingSphere;
import com.jme.image.Texture;
import com.jme.light.PointLight;
import com.jme.math.Vector3f;
import com.jme.renderer.ColorRGBA;
import com.jme.scene.Node;
import com.jme.scene.shape.Box;
import com.jme.scene.shape.Sphere;
import com.jme.scene.state.LightState;
import com.jme.scene.state.MaterialState;
import com.jme.scene.state.TextureState;
import com.jme.util.TextureManager;

public class HelloStates extends SimpleGame {

	@Override
	protected void simpleInitGame() {
		// Create objects
		Box b = new Box("my box",new Vector3f(1,1,1),new Vector3f(2,2,2));
		b.setModelBound(new BoundingBox());
		b.updateModelBound();
		
		Sphere s = new Sphere("my sphere",15,15,1);
		s.setModelBound(new BoundingSphere());
		s.updateModelBound();
		
		Node n = new Node("my root node");
		
		// get texture URL
		URL monkeyLoc;
		monkeyLoc=HelloStates.class.getClassLoader().getResource("jmetest/data/images/Monkey.jpg");
		// added some extra info here. it seems the above url goes to the bin folder under src.
		// I didn't expect that. Is that some kind of automatic searching or is it default folder?
		try{
			System.out.println(monkeyLoc.toString());
		} catch (NullPointerException np){
			System.out.println("monkeyLoc WAS NULL!!");
		}
		
		// get texture state
		TextureState ts = display.getRenderer().createTextureState();
		// use TextureState to load a texture
		Texture t = TextureManager.loadTexture(monkeyLoc,
				Texture.MM_LINEAR,
				Texture.FM_LINEAR);
		// assign the texture to the TextureState
		ts.setTexture(t);
		
		// get a MaterialState
		MaterialState ms = display.getRenderer().createMaterialState();
		// give the MaterialState an emissive tint
		ms.setEmissive(new ColorRGBA(0f,.2f,0f,1));
		 
		//create a point light
		PointLight l = new PointLight();
		// give it a location
		l.setLocation(new Vector3f(0,10,5));
		// give it a red color
		l.setDiffuse(ColorRGBA.red);
		// enable it
		l.setEnabled(true);
		
		// create a LightState to put my light in
		LightState ls = display.getRenderer().createLightState();
		// attach the light
		ls.attach(l);
		
		// signal that b should use RenderState ts
		b.setRenderState(ts);
		// signal that n should use RenderState ms
		n.setRenderState(ms);
		
		// detach all the default lights made by SimpleGames
		lightState.detachAll();
		// make my light affect everything below node n
		n.setRenderState(ls);
		// attach b and s to n and n to rootNode
		n.attachChild(b);
		n.attachChild(s);
		rootNode.attachChild(n);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloStates app = new HelloStates();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

}
