package myjME.testing;

import java.security.SecureClassLoader;

public class TestingClassLoader {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		TestingClassLoader t = new TestingClassLoader();
		t.start();
	}
	
	public void start(){
		try{
			ICanAddNumbers foo = getAddClass(1);
			System.out.println(foo.add(2, 3)); // expected output "5"
			foo = getAddClass(2); 
			System.out.println(foo.add(2, 3)); // expected output "32"
			foo = getAddClass(3); // expected to catch exception here
		} catch(PluginNotLoadedException e){
			System.out.println("Unable to load plugin: "+e); 
		}
	}
	
	private ICanAddNumbers getAddClass(int i) throws PluginNotLoadedException {
		Class<ICanAddNumbers> loaded;
		ICanAddNumbers object;
		try {
			ClassLoader cl = SecureClassLoader.getSystemClassLoader();
			if(i==1){
				loaded = (Class<ICanAddNumbers>)(cl.loadClass("myjME.testing.DynamicClass1"));
			} else if(i==2) {
				loaded = (Class<ICanAddNumbers>)(cl.loadClass("myjME.testing.DynamicClass2"));
			} else {
				loaded = (Class<ICanAddNumbers>)(cl.loadClass("myjME.testing.DynamicClass3"));
			}
			object = (ICanAddNumbers)loaded.newInstance();
		} catch(ClassNotFoundException e){
			throw new PluginNotLoadedException("Plugin class not found: DynamicClass"+i);
		} catch(IllegalAccessException e){
			throw new PluginNotLoadedException("Caught IllegalAccessException when loading the plugin DynamicClass"+i);
		} catch(InstantiationException e){
			throw new PluginNotLoadedException("Caught InstantiationException when loading the plugin DynamicClass"+i);
		}
		
		return object;
	}
	
	class PluginNotLoadedException extends Exception {
		public PluginNotLoadedException(String message) {
            // Constructor.  Create a ParseError object containing
            // the given message as its error message.
			super(message);
		}
	}
	
	public interface ICanAddNumbers {
		public int add(int a, int b);
	}
}
