package eval_datalog_arithmetic;

import java.io.FileInputStream;
import java.io.IOException;

import org.semanticweb.rulewerk.core.model.api.PositiveLiteral;
import org.semanticweb.rulewerk.core.reasoner.KnowledgeBase;
import org.semanticweb.rulewerk.core.reasoner.Reasoner;
import org.semanticweb.rulewerk.parser.ParsingException;

public class Main {

	private enum Option {
		CHECK_QUERY, INFERENCES
	}

	private static Option option;
	private static String inputKBFilePath;
	private static boolean debug;
	private static String queryToCheckEntailment;

	public static void main(String[] args) throws ParsingException, IOException {
		final Timer experimentTimer = new Timer();

		processArgs(args);
		// TODO validate arguments

		final TimedReasoner timedReasoner = new TimedReasoner();
		timedReasoner.setOutputFilePath(inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".out");
		if (debug) {
			timedReasoner.setDebug(true);
			timedReasoner.setDebugOutput(inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".DEBUG");
		}

		final FileInputStream kbFile = new FileInputStream(inputKBFilePath);

		switch (option) {
		case CHECK_QUERY:
			checkEntailment(timedReasoner, queryToCheckEntailment, kbFile);
			break;
		case INFERENCES:
			writeInferences(timedReasoner, kbFile);
			break;
		}

		experimentTimer.printDuration("Total experiment");
	}

	public static void processArgs(String[] args) {
		try {
			option = Option.valueOf(args[0]);
			inputKBFilePath = args[1];
			debug = Boolean.parseBoolean(args[2]);

			if (option == Option.CHECK_QUERY) {
				queryToCheckEntailment = args[3];
			}
		} catch (Exception e) {
			printHelp();
			throw new IllegalArgumentException(e);
		}
	}

	private static void printHelp() {
		// TODO
		System.out.println("Experiment  options: ");
		System.out.println(
				" - " + Option.CHECK_QUERY + " <input .rls file path> <boolean debug> <query to check entailment>");
		System.out.println(" - " + Option.INFERENCES + " <input .rls file path> <boolean debug>");
	}

	public static void checkEntailment(final TimedReasoner timedReasoner, final String queryToCheckEntailent,
			FileInputStream inputKB) throws ParsingException, IOException {
		final PositiveLiteral query = timedReasoner.parseQuery(queryToCheckEntailent);
		final KnowledgeBase kb = timedReasoner.parseKB(inputKB);

		try (Reasoner reasoner = timedReasoner.createReasoner(kb)) {
			timedReasoner.reason(reasoner);
			boolean isEntailed = timedReasoner.isEntailed(reasoner, query);

			System.out.println("Experiment result: " + isEntailed);
		}
	}

	public static void writeInferences(final TimedReasoner timedReasoner, final FileInputStream inputKB)
			throws IOException, ParsingException {
		final KnowledgeBase kb = timedReasoner.parseKB(inputKB);

		try (Reasoner reasoner = timedReasoner.createReasoner(kb)) {
			timedReasoner.reason(reasoner);
			timedReasoner.writeInferences(reasoner);
		}
	}

}
