package myjME.testing.game;

import com.jme.app.SimpleGame;
import com.jme.input.KeyBindingManager;
import com.jme.input.KeyInput;
import myjME.testing.game.items.vehicles.*;

public class SimpleGame1 extends SimpleGame {
	SpaceShip player;

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
		player.simpleUpdate();
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
