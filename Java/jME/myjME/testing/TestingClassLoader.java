package myjME.testing;

import java.security.SecureClassLoader;

public class TestingClassLoader {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		try{
			//Class type = ClassLoader.getSystemClassLoader().loadClass("myjME.testing.DynamicClass1");
			Class type = SecureClassLoader.getSystemClassLoader().loadClass("myjME.testing.DynamicClass1");
			ICanAddNumbers foo = (ICanAddNumbers)type.newInstance();
			System.out.println(foo.add(2, 3));
			type = ClassLoader.getSystemClassLoader().loadClass("myjME.testing.DynamicClass2");
			System.out.println(foo.add(2, 3));
			foo = (ICanAddNumbers)type.newInstance();
			System.out.println(foo.add(2, 3));
		} catch(Exception badHandling){
			System.out.println(badHandling);
		} 
	}

	public interface ICanAddNumbers {
		public int add(int a, int b);
	}
}
