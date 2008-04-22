package myjME.utils;

/**
* Keeps a ring array of objects with thread-safe put and get methods.
* 
* @author Anders Fongen
*/
public class FIFO/*<E>*/ {
	private int front, back, capacity;
	private Condition dataElements, freeSpace;
	private Object[] storage;
	
	public FIFO(int cap) {
		storage = new Object[cap];
		capacity = cap;
		dataElements = new Condition(0);
		freeSpace = new Condition(cap);
		front = 0; back = 0;
	}

	private synchronized <E> void in(Object obj) {
		// Put data into ring buffer
		storage[back] = obj;
		back = (back+1) % capacity;
	}

	private synchronized <E> Object out() {
		// Get data from ring buffer
		Object obj;
		obj = storage[front];
		front = (front+1) % capacity;
		return obj;
	}

	public <E> void put(Object obj) {
		freeSpace.condWait();
		in(obj);
		dataElements.condNotify();
	}

	public <E> Object get() {
		dataElements.condWait();
		Object obj = out();
		freeSpace.condNotify();
		return obj;
	}
} 
