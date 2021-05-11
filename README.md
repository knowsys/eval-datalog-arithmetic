# Evaluation data and software

This repository contains auxiliary resources for the following research work:

**A Datalog Hammer for Supervisor Verification Conditions Modulo Simple Linear Arithmetic**
by Martin Bromberger, Irina Dragoste, Rasha Faqeh, Christof Fetzer, Markus Krötzsch, and Christoph Weidenbach. 2021.


## Toolchain

The different steps in our toolchain have to be executed manually. In the first step [SPASS-SPL](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/bin/SPASS-SPL) transforms an HBS(SLR)PP problem in the FTCNF language (described below) into an equisatisfiable HBS problem in the Datalog language, using the [Rulewerk rule syntax](https://github.com/knowsys/rulewerk/wiki/Rule-syntax-grammar). 

The bash command looks as follows for universal conjectures:

    ./bin/SPASS-SPL -d -n <file>.ftcnf > <file>.rls
    
The bash command looks as follows for existential conjectures:

    ./bin/SPASS-SPL -d <file>.ftcnf > <file>.rls

Secondly, the Datalog `.rls` file is processed by the [VLog](https://github.com/karmaresearch/vlog) Java API [Rulewrk](https://github.com/knowsys/rulewerk). We created a [small java project eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) that uses [Rulewerk](https://github.com/knowsys/rulewerk) to load the `.rls` Knowledge Base, materialise it via the Datalog engine [VLog](https://github.com/karmaresearch/vlog), and query for a Goal fact. We separately measure parsing, loading, reasoning (materialisation) and querying in miliseconds.
[The .jar we used to run our experiments](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic_linux.jar) is built for a Linux machine.  Alternatively, one can locally build their own jar (also on  macOS) using the instructions [here](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/BUILDING-EVAL-JAR_README.md).

To reproduce our experiments, one can run this jar with the following arguments:

    CHECK_QUERY <file>.rls false "Goal(?x0)"

For example, for evaluating Benchmark [lc_e1](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/Benchmarks/datalog/lc_e1.rls), one must run
    
    java -jar -Xms8G code-eval-datalog-arithmetic_linux.jar CHECK_QUERY lc_e1.rls false "Goal(?x0)"

In our experiments we ran Java with the `-Xms8G` option, but the default reserved memory for Java also suffices.

For debugging purposes, one can run this program with options
```CHECK_QUERY <file>.rls true "Goal(?x0)"```
which will output the [VLog](https://github.com/karmaresearch/vlog) engine log at DEBUG level in new `.DEBUG` file.

For checking all (implicit and explicit) facts derived during materialisation, one can run
```INFERENCES <file>.rls <true|false>```
which will output all these facts in Datalog syntax in a new `.out` file. If the third argument is `true`, a `.DEBUG` file will also be created. 

To summarize, the **sequence of bash commands** to execute our tool chain looks as follows:

    ./bin/SPASS-SPL -d -n <file>.ftcnf > <file>.rls
    java -jar -Xms8G code-eval-datalog-arithmetic_linux.jar CHECK_QUERY <file>.rls false "Goal(?x0)"

For instance, for the file `Benchmarks/ftcnf/ecu_u1.ftcnf` the commands would be:

    ./bin/SPASS-SPL -d -n Benchmarks/ftcnf/ecu_u1.ftcnf > Benchmarks/ftcnf/ecu_u1.rls
    java -jar -Xms8G code-eval-datalog-arithmetic_linux.jar CHECK_QUERY Benchmarks/ftcnf/ecu_u1.rls false "Goal(?x0)"
    
We also precomputed all problems into the various formats and they can be executed directly. For instance, `Benchmarks/datalog/ecu_u1.rls` is the output of `./bin/SPASS-SPL -d -n Benchmarks/ftcnf/ecu_u1.ftcnf`

## FTCNF Language
FTCNF is the input language of SPASS-SPL. It is possible to express any BS(LA) formula in this language. SPASS-SPL has 3 sorts: "R" for Real, "I" for Integer, and "F", which stands for a finite set whose elements are exactly the constants of the sort. Default sort for all variables and constants is "R". Default sort for all predicates with an argument of sort "R" or "I" is "R". Default sort for all predicates with an argument of sort "F" is "F".

A clause written in the language looks as follows:

    <(+(-(*(3,x),*(x,e(y,2))),6),5),  =(y,z) || P(x,y), Q(z,w) -> R(a,w), Q(z,z).

The full grammar of the language is defined below:

    <preamble>   ::= [["p("<var>":"<RIF>")" | "p("<const>":"<RIF>")"] [","["p("<var>":"<RIF>")" | "p("<const>":"<RIF>")"]]*]
    <comment>    ::= "%" <anystring until EOL>
    
    <clause>     ::= [<constraint> "||"] <atoms> -> <atoms> "."
    <gclause>    ::= g [<constraint> "||"] -> <atom> "."
    <tclause>    ::= t <catom> "||" -> <atom> "."
    <constraint> ::= <catom> ["," <catom>]*
    <atoms>      ::= [<atom> ["," <atom>]*]
    <atom>       ::= <upercaseletter>[<number> | <letter>]*"("[<terms>]")"
    <terms>      ::= <term> ["," <term>]*
    <term>       ::= <var> | <const>
    <RIF>        ::= "R" | "I" | "F" 
    <const>      ::= <abcd>[[<lowercasestring>] | [<RIF>] | [<number>]]*
    <var>        ::= <xyzuvw>[[<lowercasestring>] | [<RIF>] | [<number>]]*
    <abcd>       ::= "a" | "b" | "c" | "d" 
    <xyzuvw>     ::= "x" | "y" | "z" | "u" | "v" | "w" 
    <catom>      ::= <crel>"("<cterm>,<cterm>")"
    <crel>       ::= "<" | ">" | "=" | "<=" | ">=" | "!="
    <cterm>      ::= "+("<cterm>,<cterm>[,<cterm>]*")" | "*("<cterm>,<cterm>[,<cterm>]*")" | "-("<cterm>,<cterm>")" | "-"<number> | <number> | <var>
    <number>     ::= ["0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"]+
    
    <SUPLOGin>   ::= <comment>* <preamble> <clause>* <tclause>* [<gclause>]

All variables in a `<clause>` are assumed to be universally quantified. The optional `<gclause>` defines a universal conjecture that is supposed to be verified for our set of clauses `<clause>*`. The string "Goal" cannot be used as a predicate symbol because it is reserved for our Datalog hammer.

SPASS-SPL is not yet able to recognize and handle theory constraints beyond simple bounds, unless they are positvely grounded variable comparisons (i.e., $x \LAOP y$ with $\LAOP \in \{\leq, <, \neq, =, >, \geq\}$). As a provisional workaround, it is possible to "highlight" positively grounded theory atoms `<catom>` manually. To do so, the theory atom has to be replaced by a first-order `<atom>` over a fresh predicate and the same variables as <catom>. The interpretation of `<atom>` can then be fixed to `<catom>` with the help of a theory pattern clause `<tclause> ::= <catom> || -> <atom>`. The Datalog hammer will then treat `<catom>` as if it were a positively grounded theory atom that always simplifies to true or false in elim(S,N). The user has to check themselves if this is actually the case or the result is no longer guaranteed to be sound.

## Transformation of FTCNF problems into other input languages

SPASS-SPL can transform ftcnf problems into the SMT-LIB 2.6 and into the CHC competition format. The respective options to do so are `-s` and `-c`.

SPASS-SPL can also be used to transform ftcnf problems into the DFG language of SPASS (with the option `-d -p`) and from DFG with the tool [dfg2tptp](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/bin/dfg2tptp) in the `bin` folder into the tptp format.

# Acknowledgements

This work is partly supported by Deutsche Forschungsgemeinschaft (DFG, German Research Foundation)
in project number 389792660 (TRR 248, [Center for Perspicuous Systems](https://www.perspicuous-computing.science/)), and by the Bundesministerium für Bildung und Forschung (BMBF, Federal Ministry of Education and Research) in the [Center for Scalable Data Analytics and Artificial Intelligence](https://www.scads.de) (ScaDS.AI).
