package linear.alg.a4.materialization;

import java.io.IOException;

import org.semanticweb.rulewerk.core.model.api.PositiveLiteral;
import org.semanticweb.rulewerk.core.reasoner.KnowledgeBase;
import org.semanticweb.rulewerk.parser.ParsingException;
import org.semanticweb.rulewerk.parser.RuleParser;
import org.semanticweb.rulewerk.reasoner.vlog.VLogReasoner;

public class Explain {

	private SimpleReasoning simpleReasoning;

	public Explain(SimpleReasoning simpleReasoning) {
		this.simpleReasoning = simpleReasoning;
	}

	public void answerIfNotEntailed(final String inputKBFilePath, final String toQuery, final String outputFilePath,
			final String queryToExplain) throws ParsingException, IOException {
		final PositiveLiteral query = RuleParser.parsePositiveLiteral(toQuery);

		final KnowledgeBase kb = this.simpleReasoning.parseKB(inputKBFilePath);

		try (VLogReasoner reasoner = this.simpleReasoning.createReasoner(kb)) {

			this.simpleReasoning.reason(reasoner);

			boolean isEntailed = this.simpleReasoning.isEntailed(reasoner, query);
			if (!isEntailed) {
				System.out.println("Writing query answers to " + queryToExplain + " to file " + outputFilePath);

				this.simpleReasoning.printQueryAnswerFacts(RuleParser.parsePositiveLiteral(queryToExplain), kb,
						reasoner, outputFilePath);
			}
		}
	}

}
