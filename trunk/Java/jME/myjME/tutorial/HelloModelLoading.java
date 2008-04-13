/**
 * 
 */
package myjME.tutorial;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.jme.app.AbstractGame;
import com.jme.app.SimpleGame;
import com.jme.bounding.BoundingSphere;
import com.jme.scene.Node;
import com.jme.util.export.binary.BinaryImporter;
import com.jmex.model.converters.FormatConverter;
import com.jmex.model.converters.Md2ToJme;

/**
 * @author Robert Græsdal
 *
 */
public class HelloModelLoading extends SimpleGame {

	/* (non-Javadoc)
	 * @see com.jme.app.BaseSimpleGame#simpleInitGame()
	 */
	@Override
	protected void simpleInitGame() {
		// Point to a URL of the model
		URL model = HelloModelLoading.class.getClassLoader().getResource("jmetest/data/model/drfreak.md2");
		
		// Create a converter
		FormatConverter converter = new Md2ToJme();
		// Point the converter to where it will find the mtl file
		converter.setProperty("mtllib",model);
		
		// this byte array will hold the jme file
		ByteArrayOutputStream BO = new ByteArrayOutputStream();
		try {
			converter.convert(model.openStream(), BO);
			Node drfreak = (Node)BinaryImporter.getInstance().load(new ByteArrayInputStream(BO.toByteArray()));
			
			// TODO: scale the model
			drfreak.setModelBound(new BoundingSphere());
			drfreak.updateModelBound();
			
			rootNode.attachChild(drfreak);
		} catch (IOException e) {
			System.out.println("Damn exceptions!" + e);
			e.printStackTrace();
            System.exit(0);
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloModelLoading app = new HelloModelLoading();
        app.setDialogBehaviour(AbstractGame.ALWAYS_SHOW_PROPS_DIALOG);
        // Turn the logger off so we can see the XML later on
        Logger.getLogger(HelloModelLoading.class.getName()).setLevel(Level.OFF);
        app.start();
	}

}
