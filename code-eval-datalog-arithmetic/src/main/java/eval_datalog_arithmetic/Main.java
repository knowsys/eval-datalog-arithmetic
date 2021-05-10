package eval_datalog_arithmetic;

import java.io.FileInputStream;
import java.io.IOException;

import org.semanticweb.rulewerk.parser.ParsingException;

public class Main {

	private enum Option {
		EXPLAIN_QUERY, INFERENCES
	}

	private static Option option;
	private static String inputKBFilePath;
	private static boolean debug;
	private static String queryToCheckEntailment;
	private static String queryToWriteQueryAnswersIfNotEntailed;

	public static void main(String[] args) throws ParsingException, IOException {
		final Timer experimentTimer = new Timer();

		processArgs(args);
		// TODO validate arguments

		final FileInputStream kbFile = new FileInputStream(args[1]);

		final TimedReasoner timedReasoner = new TimedReasoner();
		timedReasoner.setOutputFilePath(inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".out");
		if (debug) {
			timedReasoner.setDebug(true);
			timedReasoner.setDebugOutput(inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".DEBUG");
		}

		switch (option) {
		case EXPLAIN_QUERY:

			final Explain explain = new Explain(timedReasoner);
			explain.answerIfNotEntailed(kbFile, queryToCheckEntailment, queryToWriteQueryAnswersIfNotEntailed);
			break;
		case INFERENCES:
			timedReasoner.writeInferences(kbFile);
			break;
		}

		experimentTimer.printDuration("Total experiment");
	}

	public static void processArgs(String[] args) {
		if (args.length < 3) {
			printHelp();
		}

		option = Option.valueOf(args[0]);
		inputKBFilePath = args[1];
		debug = Boolean.parseBoolean(args[2]);

		if (option == Option.EXPLAIN_QUERY) {
			queryToCheckEntailment = args[3];
			queryToWriteQueryAnswersIfNotEntailed = args[4];
		}
	}
	
	private static void printHelp() {
		//TODO
	}

}
