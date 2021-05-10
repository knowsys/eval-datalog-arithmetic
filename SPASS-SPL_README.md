## Toolchain

The different steps in our toolchain have to be executed manually. In the first step SPASS-SPL transform an HBS(SLR)PP problem in the FTCNF language into an equisatisfiable HBS problem in the Datalog language, using the [Rulewerk rule syntax](https://github.com/knowsys/rulewerk/wiki/Rule-syntax-grammar). 

The bash commands look as follows:

    ./SPASS-SPL -d -n <file>.ftcnf > <file>.rls

Secondly, the Datalog `.rls` file is processed by the [VLog](https://github.com/karmaresearch/vlog) Java API [Rulewrk](https://github.com/knowsys/rulewerk). We created a [small java project](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-rulewerk-eval) that uses [Rulewrk](https://github.com/knowsys/rulewerk) to load the `.rls` Knowledge Base, materialise it via the Datalog engine  [VLog](https://github.com/karmaresearch/vlog), and query for a Goal fact. If no Goal fact is derived, an alternative given query is answered to provide an explanation. We separately measure parsing, loading, reasoning (materialisation) and querying in miliseconds.

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

SPASS-SPL can trasform ftcnf problems into the SMT-LIB 2.6 and into the CHC competition format. The respective options to do so are `-s` and `-c`.
