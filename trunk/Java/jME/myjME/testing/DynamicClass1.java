package myjME.testing;

import myjME.testing.TestingClassLoader.ICanAddNumbers;

public class DynamicClass1 implements ICanAddNumbers {

	@Override
	public int add(int a, int b) {
		// TODO Auto-generated method stub
		return a+b;
	}

}
