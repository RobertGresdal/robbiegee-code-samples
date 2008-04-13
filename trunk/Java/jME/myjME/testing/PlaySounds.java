package myjME.testing;

import com.jme.app.SimpleGame;
import com.jme.math.Vector3f;
import com.jme.scene.shape.Box;
import com.jmex.audio.AudioSystem;
import com.jmex.audio.AudioTrack;

public class PlaySounds extends SimpleGame {
	AudioTrack music;
	
	@Override
	protected void simpleInitGame() {
		setupSound();
		
		Box box = new Box("My box",new Vector3f(0,0,0),new Vector3f(1,1,1));
		rootNode.attachChild(box);
	}

	
	private void setupSound(){
		
		AudioSystem audio = AudioSystem.getSystem();
		audio.getEar().trackOrientation(cam);
		audio.getEar().trackPosition(cam);
		// create program sound
		music = audio.createAudioTrack(getClass(). 
			getResource("/jmetest/data/sound/Katoku Pokus.ogg"),true);
		music.setVolume(1.0f);
		music.play();
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		PlaySounds app = new PlaySounds();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

}
