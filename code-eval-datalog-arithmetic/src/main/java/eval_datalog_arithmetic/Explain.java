package eval_datalog_arithmetic;

import java.io.FileInputStream;
import java.io.IOException;

import org.semanticweb.rulewerk.core.model.api.PositiveLiteral;
import org.semanticweb.rulewerk.core.reasoner.KnowledgeBase;
import org.semanticweb.rulewerk.core.reasoner.Reasoner;
import org.semanticweb.rulewerk.parser.ParsingException;

public class Explain {

	private final TimedReasoner timedReasoner;

	public Explain(TimedReasoner simpleReasoning) {
		this.timedReasoner = simpleReasoning;
	}

	public void answerIfNotEntailed(final FileInputStream inputKB, final String queryToCheckEntailent,
			final String queryToAnswerIfNotEntailed) throws ParsingException, IOException {

		final PositiveLiteral query = this.timedReasoner.parseQuery(queryToCheckEntailent);

		final KnowledgeBase kb = this.timedReasoner.parseKB(inputKB);

		try (Reasoner reasoner = this.timedReasoner.createReasoner(kb)) {

			this.timedReasoner.reason(reasoner);

			boolean isEntailed = this.timedReasoner.isEntailed(reasoner, query);
			if (!isEntailed) {
				this.timedReasoner.writeQueryAnswerFacts(this.timedReasoner.parseQuery(queryToAnswerIfNotEntailed),
						kb, reasoner);
			}
		}
	}

}
