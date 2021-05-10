package eval_datalog_arithmetic;

public class Timer {

	private final long initTime;

	public Timer() {
		this.initTime = System.currentTimeMillis();
	}

	public void printDuration(String message) {
		System.out.println(message +" duration: "+ this.getDuration() + " ms.");
	}

	private long getDuration() {
		return System.currentTimeMillis() - this.initTime;
	}

}
