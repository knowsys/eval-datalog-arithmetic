package linear.alg.a4.materialization;

import java.io.IOException;

import org.semanticweb.rulewerk.parser.ParsingException;

public class Experiment {

	private enum Option {
		EXPLAIN_QUERY, INFERENCES
	}

	public static void main(String[] args) throws ParsingException, IOException {
		final long start = System.currentTimeMillis();

		final Option option = Option.valueOf(args[0]);

		final String inputKBFilePath = args[1];

		final boolean debug = Boolean.parseBoolean(args[2]);

		final String outputFilePath = inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".out";

		final String debugFilePath = inputKBFilePath + "." + option + "-" + System.currentTimeMillis() + ".DEBUG";

		final SimpleReasoning simpleReasoning = new SimpleReasoning(debug, debugFilePath);

		switch (option) {
		case EXPLAIN_QUERY:
			final String toCheckEntailment = args[3];
			final String toWriteQueryAnswers = args[4];
			final Explain explain = new Explain(simpleReasoning);
			explain.answerIfNotEntailed(inputKBFilePath, toCheckEntailment, outputFilePath, toWriteQueryAnswers);
			break;
		case INFERENCES:
			simpleReasoning.writeInferences(inputKBFilePath, outputFilePath);
			break;
		}

		System.out.println("Total experiment duration: " + (System.currentTimeMillis() - start) + " ms");
	}

}
