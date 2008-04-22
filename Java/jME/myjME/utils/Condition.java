package myjME.utils;

public class Condition {
	private int fulfilled;
	public Condition(int initial) { fulfilled = initial; }
	public Condition() { this(0); }
	public synchronized void condNotify() {
		fulfilled++; notify(); 
	}
	
	public synchronized void condWait() {
		while (fulfilled==0){
			try { wait(); }
			catch (InterruptedException e) {}
		}
		fulfilled--;
	}
} 
