package myjME.testing.game;

import com.jme.app.SimpleGame;
import com.jme.input.KeyBindingManager;
import com.jme.input.KeyInput;
import myjME.testing.game.items.vehicles.*;

public class SimpleGame1 extends SimpleGame {
	SpaceShip player;
	
	public SimpleGame1() {
		// TODO Auto-generated constructor stub
		
	}

	@Override
	protected void simpleInitGame() {
		initAudio();
		initScene();
		initInput();
	}
	
	private void initAudio(){
		
	}
	private void initScene(){
		player = new SpaceShip();
		rootNode.attachChild(player.getNode());
	}
	private void initInput(){
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
			player.thrust(0.02f);
		}
		// if the coordsDown was activated
		if(KeyBindingManager.getKeyBindingManager().isValidCommand("moveDown",true)){
			player.thrust(-0.02f);
		}
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("rotLeft",true)){
			player.turn(0.005f);
		}
		if (KeyBindingManager.getKeyBindingManager().isValidCommand("rotRight",true)){
			player.turn(-0.005f);
		}
		/*
		Quaternion q=new Quaternion();
		q.fromAngleAxis(player.rotation,new Vector3f(0,0,1));
		
		n.setLocalTranslation(player.x, player.y, player.z);
		n.setLocalRotation(q);*/
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		SimpleGame1 app = new SimpleGame1();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

}
