package linear.alg.a4.materialization;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Calendar;

import org.semanticweb.rulewerk.core.model.api.PositiveLiteral;
import org.semanticweb.rulewerk.core.model.api.PrefixDeclarationRegistry;
import org.semanticweb.rulewerk.core.model.api.QueryResult;
import org.semanticweb.rulewerk.core.model.implementation.Serializer;
import org.semanticweb.rulewerk.core.reasoner.Correctness;
import org.semanticweb.rulewerk.core.reasoner.KnowledgeBase;
import org.semanticweb.rulewerk.core.reasoner.LogLevel;
import org.semanticweb.rulewerk.core.reasoner.QueryResultIterator;
import org.semanticweb.rulewerk.parser.ParsingException;
import org.semanticweb.rulewerk.parser.RuleParser;
import org.semanticweb.rulewerk.reasoner.vlog.VLogReasoner;

public class SimpleReasoning {

	private boolean debug;
	private String debugOutput;

	public SimpleReasoning(boolean debug, String debugOutput) {
		super();
		this.debug = debug;
		this.debugOutput = debugOutput;
	}

	public KnowledgeBase parseKB(String kbFilePath) throws ParsingException, FileNotFoundException {
		final long startPars = System.currentTimeMillis();
		final KnowledgeBase kb = RuleParser.parse(new FileInputStream(kbFilePath));
		System.out.println(" - Parsing kb from file duration: " + (System.currentTimeMillis() - startPars) + " ms");
		return kb;
	}

	public PositiveLiteral parseQuery(String query) throws ParsingException {
		final long startPars = System.currentTimeMillis();
		final PositiveLiteral literal = RuleParser.parsePositiveLiteral(query);
		System.out.println(
				" - Parsing query " + query + "  duration: " + (System.currentTimeMillis() - startPars) + " ms");
		return literal;
	}

	public VLogReasoner createReasoner(KnowledgeBase kb) {
		long startCreateReas = System.currentTimeMillis();
		VLogReasoner reasoner = new VLogReasoner(kb);

		if (this.debug) {
			reasoner.setLogLevel(LogLevel.DEBUG);
			reasoner.setLogFile(this.debugOutput);
			System.out.println("VLog Reasoner DEBUG log written to " + this.debugOutput);
		}

		System.out.println(
				" - Creating reasoner object duration: " + (System.currentTimeMillis() - startCreateReas) + " ms");
		return reasoner;
	}

	public void reason(VLogReasoner reasoner) throws IOException {
		long startReas = System.currentTimeMillis();
		System.out.println("Start reasoning: " + Calendar.getInstance().getTime());
		reasoner.reason();
		System.out.println(
				" - Reasoning (reasoner.reason()) duration: " + (System.currentTimeMillis() - startReas) + " ms");
	}

	public void writeInferences(final String kbFilePath, final String outputFilePath)
			throws IOException, ParsingException {
		final KnowledgeBase kb = this.parseKB(kbFilePath);
		try (VLogReasoner reasoner = this.createReasoner(kb)) {
			this.reason(reasoner);
			this.writeInferences(outputFilePath, reasoner);
		}
	}

	private void writeInferences(final String outputFilePath, VLogReasoner reasoner)
			throws IOException, FileNotFoundException {
		long start = System.currentTimeMillis();

		try (final PrintWriter writer = new PrintWriter(outputFilePath)) {
			reasoner.writeInferences(writer);
		}
		System.out.println(" - Writing all inferences duration: " + (System.currentTimeMillis() - start) + " ms");
	}

	public void printQueryAnswerFacts(PositiveLiteral query, KnowledgeBase kb, VLogReasoner reasoner,
			String outputFilePath) throws IOException {
		final long startQ = System.currentTimeMillis();
		try (final Writer writer = new PrintWriter(outputFilePath)) {

			final PrefixDeclarationRegistry prefixDeclarationRegistry = kb.getPrefixDeclarationRegistry();
			final Serializer serializer = new Serializer(writer, prefixDeclarationRegistry);
			serializer.writePrefixDeclarationRegistry(prefixDeclarationRegistry);

			this.answerQuery(writer, reasoner, serializer, query);
		}
		System.out.println("Total printing query answer for " + query + " duration: "
				+ (System.currentTimeMillis() - startQ) + " ms");
	}

	private void answerQuery(Writer writer, VLogReasoner reasoner, final Serializer serializer, PositiveLiteral query)
			throws IOException {
		long startQ = System.currentTimeMillis();

		System.out.println("Answering query: " + query);
		try (final QueryResultIterator iterator = reasoner.answerQuery(query, true)) {
			while (iterator.hasNext()) {
				final QueryResult queryResult = iterator.next();

				serializer.writePositiveLiteral(query.getPredicate(), queryResult.getTerms());
				writer.write(" .\n");
			}
		}
		System.out.println(" - Query answering duration: " + (System.currentTimeMillis() - startQ) + " ms");
	}

	public boolean isEntailed(VLogReasoner reasoner, PositiveLiteral query) {
		long startQ = System.currentTimeMillis();
		boolean isEntailed = false;

		System.out.println("Checking entailment of query: " + query);
		try (QueryResultIterator iterator = reasoner.answerQuery(query, true)) {

			if (iterator.hasNext() && iterator.getCorrectness().equals(Correctness.SOUND_AND_COMPLETE)) {
				isEntailed = true;
			}
		}
		System.out.println(" - Query entaiment check duration: " + (System.currentTimeMillis() - startQ)
				+ " ms; Is entailed: " + isEntailed + "\n");
		return isEntailed;
	}

}
