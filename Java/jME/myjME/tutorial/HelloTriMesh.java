package myjME.tutorial;

import com.jme.app.SimpleGame;
import com.jme.bounding.BoundingBox;
import com.jme.math.Vector2f;
import com.jme.math.Vector3f;
import com.jme.renderer.ColorRGBA;
import com.jme.scene.TriMesh;
import com.jme.util.geom.BufferUtils;

public class HelloTriMesh extends SimpleGame {

	@Override
	protected void simpleInitGame() {
		// create generic trimesh
		TriMesh m = new TriMesh("My mesh");
		// vertex positions for the mesh
		Vector3f[] vertexes = {
				new Vector3f(0,0,0),
				new Vector3f(1,0,0),
				new Vector3f(0,1,0),
				new Vector3f(1,1,0)
		};
		// normal directions for each vertex position
		Vector3f[] normals = {
				new Vector3f(0,0,1),
				new Vector3f(0,0,1),
				new Vector3f(0,0,1),
				new Vector3f(0,0,1)
		};
		ColorRGBA[] colors = {
				new ColorRGBA(1,0,0,1),
				new ColorRGBA(1,0,0,1),
				new ColorRGBA(0,1,0,1),
				new ColorRGBA(0,1,0,1)
		};
		// texture coordinates for each position
		Vector2f[] texCoords = {
				new Vector2f(0,0),
				new Vector2f(1,0),
				new Vector2f(0,1),
				new Vector2f(1,1)
		};
		// The indexes of each vertex/normal/color/texcoord sets. every
		// 3 makes a triangle.
		int[] indexes = {
				0,1,2,1,2,3
		};
		// feed the information to the TriMesh
		m.reconstruct(
			BufferUtils.createFloatBuffer(vertexes),
			BufferUtils.createFloatBuffer(normals),
			BufferUtils.createFloatBuffer(colors),
			BufferUtils.createFloatBuffer(texCoords),
			BufferUtils.createIntBuffer(indexes)
		);
		// create bounds
		m.setModelBound(new BoundingBox());
		m.updateModelBound();
		// attach the scene to the scene graph
		rootNode.attachChild(m);
		lightState.setEnabled(false);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		HelloTriMesh app = new HelloTriMesh();
		app.setDialogBehaviour(SimpleGame.ALWAYS_SHOW_PROPS_DIALOG);
		app.start();
	}

}
