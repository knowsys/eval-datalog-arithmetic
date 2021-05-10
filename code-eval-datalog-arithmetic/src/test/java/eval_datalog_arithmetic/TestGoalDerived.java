package eval_datalog_arithmetic;

import static org.junit.Assert.assertTrue;

import java.io.IOException;

import org.junit.Test;
import org.semanticweb.rulewerk.core.reasoner.KnowledgeBase;
import org.semanticweb.rulewerk.parser.ParsingException;
import org.semanticweb.rulewerk.parser.RuleParser;
import org.semanticweb.rulewerk.reasoner.vlog.VLogReasoner;

import eval_datalog_arithmetic.SimpleReasoning;

public class TestGoalDerived {

	SimpleReasoning simpleReasoning = new SimpleReasoning(false, "");

	@Test
	public void testGoalSimplified() throws ParsingException, IOException {
		final String inputKBFilePath = "src/test/resources/simplified_ign_exist_yes.datalog";

		final KnowledgeBase kb = this.simpleReasoning.parseKB(inputKBFilePath);

		try (VLogReasoner reasoner = this.simpleReasoning.createReasoner(kb)) {

			this.simpleReasoning.reason(reasoner);

			assertTrue(this.simpleReasoning.isEntailed(reasoner, RuleParser.parsePositiveLiteral("Goal(?x)")));
		}
	}

	@Test
	public void testGoal() throws ParsingException, IOException {
		final String inputKBFilePath = "src/test/resources/ign_exist_yes.datalog";

		final KnowledgeBase kb = this.simpleReasoning.parseKB(inputKBFilePath);

		try (VLogReasoner reasoner = this.simpleReasoning.createReasoner(kb)) {

			this.simpleReasoning.reason(reasoner);

			assertTrue(this.simpleReasoning.isEntailed(reasoner, RuleParser.parsePositiveLiteral("Goal(?x)")));
		}
	}
}
