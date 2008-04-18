package myjME.testing;

import myjME.testing.TestingClassLoader.ICanAddNumbers;

public class DynamicClass2 implements ICanAddNumbers {

	@Override
	public int add(int a, int b) {
		return (a+(b*10));
	}

}
