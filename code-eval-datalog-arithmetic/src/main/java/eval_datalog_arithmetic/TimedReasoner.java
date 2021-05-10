package eval_datalog_arithmetic;

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
import org.semanticweb.rulewerk.core.reasoner.Reasoner;
import org.semanticweb.rulewerk.parser.ParsingException;
import org.semanticweb.rulewerk.parser.RuleParser;
import org.semanticweb.rulewerk.reasoner.vlog.VLogReasoner;

public class TimedReasoner {

	private String outputFilePath;
	private boolean debug;
	private String debugOutput;

	public KnowledgeBase parseKB(final FileInputStream kbFile) throws ParsingException, FileNotFoundException {
		final Timer timer = new Timer();
		final KnowledgeBase kb = RuleParser.parse(kbFile);
		timer.printDuration(" - Parsing knowledge base from file duration: ");
		return kb;
	}

	public PositiveLiteral parseQuery(final String query) throws ParsingException {
		final Timer timer = new Timer();
		final PositiveLiteral literal = RuleParser.parsePositiveLiteral(query);
		timer.printDuration(" - Parsing query " + query);
		return literal;
	}

	public Reasoner createReasoner(final KnowledgeBase kb) {
		final Timer timer = new Timer();
		final Reasoner reasoner = new VLogReasoner(kb);

		if (this.debug) {
			reasoner.setLogLevel(LogLevel.DEBUG);
			reasoner.setLogFile(this.debugOutput);
			System.out.println("VLog Reasoner DEBUG log written to " + this.debugOutput);
		}

		timer.printDuration(" - Creating reasoner and loading the knowladge base");
		return reasoner;
	}

	public void reason(final Reasoner reasoner) throws IOException {
		final Timer timer = new Timer();

		System.out.println(Calendar.getInstance().getTime() + ": Start reasoning.");
		reasoner.reason();

		timer.printDuration(" - Reasoning (materialisation)");
	}

	public void writeInferences(final Reasoner reasoner) throws IOException, FileNotFoundException {
		final Timer timer = new Timer();

		System.out.println("Writing all inferences to " + this.outputFilePath);
		try (final PrintWriter writer = new PrintWriter(this.outputFilePath)) {
			reasoner.writeInferences(writer);
		}
		timer.printDuration(" - Writing all inferences");
	}

	public void writeQueryAnswerFacts(final PositiveLiteral query, final KnowledgeBase kb, final Reasoner reasoner)
			throws IOException {
		final Timer timer = new Timer();

		System.out.println("   Writing query answers to " + query + " to file " + this.outputFilePath);

		try (final Writer writer = new PrintWriter(this.outputFilePath)) {

			final PrefixDeclarationRegistry prefixDeclarationRegistry = kb.getPrefixDeclarationRegistry();
			final Serializer serializer = new Serializer(writer, prefixDeclarationRegistry);
			serializer.writePrefixDeclarationRegistry(prefixDeclarationRegistry);

			this.answerQuery(writer, reasoner, serializer, query);
		}

		timer.printDuration(" - Total writing query answers for " + query);
	}

	private void answerQuery(final Writer writer, final Reasoner reasoner, final Serializer serializer,
			final PositiveLiteral query) throws IOException {

		try (final QueryResultIterator iterator = reasoner.answerQuery(query, true)) {
			while (iterator.hasNext()) {
				final QueryResult queryResult = iterator.next();

				serializer.writePositiveLiteral(query.getPredicate(), queryResult.getTerms());
				writer.write(" .\n");
			}
		}
	}

	public boolean isEntailed(final Reasoner reasoner, final PositiveLiteral query) {
		final Timer timer = new Timer();

		boolean isEntailed = false;

		System.out.println("Checking entailment of query: " + query);
		try (QueryResultIterator iterator = reasoner.answerQuery(query, true)) {

			if (iterator.hasNext() && iterator.getCorrectness().equals(Correctness.SOUND_AND_COMPLETE)) {
				isEntailed = true;
			}
		}
		timer.printDuration(" - Query entailed: " + isEntailed + "; entailment check");
		return isEntailed;
	}

	public String getOutputFilePath() {
		return this.outputFilePath;
	}

	public void setOutputFilePath(String outputFilePath) {
		this.outputFilePath = outputFilePath;
	}

	public boolean isDebug() {
		return this.debug;
	}

	public void setDebug(boolean debug) {
		this.debug = debug;
	}

	public String getDebugOutput() {
		return this.debugOutput;
	}

	public void setDebugOutput(String debugOutput) {
		this.debugOutput = debugOutput;
	}

}
