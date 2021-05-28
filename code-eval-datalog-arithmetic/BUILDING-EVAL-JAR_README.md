# Instructions for building evaluation jar

For running our evaluation code [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) on a MacOS, Linux or Windows machine with Java 1.8 (or above) and [Maven](https://maven.apache.org/guides/getting-started/) installed:

   1. Run `mvn package` in `code-eval-datalog-arithmetic` directory. 
   2. You will now find an executable jar named `code-eval-datalog-arithmetic.jar` in `code-eval-datalog-arithmetic/target` directory. 
   3. Run `code-eval-datalog-arithmetic.jar` as shown [here](https://github.com/knowsys/eval-datalog-arithmetic#toolchain) (alternatively, run `Main.java` from your prefered IDE). 


Project [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) requires `rulewek-parser` and `rulewerk-vlog` [Rulewerk](https://github.com/knowsys/rulewerk)  modules, as it can be seen in the [pom.xml](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/pom.xml) file. In turn, `rulewerk-vlog` module requires a `vlog-java` [VLog](https://github.com/karmaresearch/vlog) dependency.
   * For obtaining the versions of [Rulewerk](https://github.com/knowsys/rulewerk) and  of [VLog](https://github.com/karmaresearch/vlog) used in [the .jar we used to run our experiments](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic_linux.jar), follow the steps shown [here](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/BUILDING-EVAL-JAR_README.md#building-evaluation-project-with-the-dependency-versions-use-in-evaluation). 
   * For [Rulewerk `v0.8.0`](https://github.com/knowsys/rulewerk/releases/tag/v0.8.0) (or higher), these depencencies can simply be obtained via Maven as shown [here](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/BUILDING-EVAL-JAR_README.md#building-evaluation-project-for-rulewerk-version-080-or-higher).

## Building evaluation project with the dependency versions use in evaluation
Our evaluation was conducted on development versions of [Rulewerk](https://github.com/knowsys/rulewerk)(`0.8.0-SNAPSHOT`, commit  [`89ace929324f9b527c56082c352af54f91f82cae`](https://github.com/knowsys/rulewerk/commit/89ace929324f9b527c56082c352af54f91f82cae)) and of [VLog](https://github.com/karmaresearch/vlog) (commit [`ca0669424963765d08a63a29a0d89e27cf33ef51`](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51)). 
In our experiments, `rulewerk-vlog` was used with a locally built `vlog-java.jar` dependency from the VLog master branch at commit tag [ca0669424963765d08a63a29a0d89e27cf33ef51](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51). 

To obtain these dependencies, one can locally clone [Rulewerk](https://github.com/knowsys/rulewerk), checkout commit [`89ace929324f9b527c56082c352af54f91f82cae`](https://github.com/knowsys/rulewerk/commit/89ace929324f9b527c56082c352af54f91f82cae), and run the attached [script](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in order to build it with the `vlog-java.jar` dependency at this specific commit tag. This script is a modified version of a modified version of the script [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh) that is used to build [Rulewerk](https://github.com/knowsys/rulewerk) with a snapshot version of [VLog](https://github.com/karmaresearch/vlog) (more details [here](https://github.com/knowsys/rulewerk#installation)).


* On a Linux or macOS system, make sure you have libstdc++-v3.4.22 or above for Linux, or macOS 10.14 or above 
* Clone [Rulewerk](https://github.com/knowsys/rulewerk).
* Optional: checkut Rulewerk commit `89ace929324f9b527c56082c352af54f91f82cae` to obtain the version of  `0.8.0-SNAPSHOT`Rulewerk used in the evaluation: `git checkout 89ace929324f9b527c56082c352af54f91f82cae`. Versions  `0.7.0` and higher should provide similar performance results, provied that `rulewerk-vlog` after commit [ca0669424963765d08a63a29a0d89e27cf33ef51](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51) is used.
* Increase the version of `vlog-java` (in `rulewerk-vlog/pom.xml`, `<karmaresearch.vlog.version>` property).
* Copy [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the `rulewerk` directory (same level as [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh), the parent directory of `rulewek-parser` and `rulewerk-vlog`).
* Run [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the `rulewerk` directory (or run the instructions in this file manually).
* Run `mvn install` in the `rulewerk` directory. This will build  and install the `rulewek-parser` and `rulewerk-vlog` modules in your local Maven repository.
* You can now use the dependencies installed in the previous step to build the [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) Java Maven project.
* Run steps [1-3](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/BUILDING-EVAL-JAR_README.md#instructions-for-building-evaluation-jar).

## Building evaluation project for Rulewerk version `0.8.0` or higher

The release of [Rulewerk `v0.8.0`](https://github.com/knowsys/rulewerk/releases/tag/v0.8.0) uses a bugfix release version of VLog [v.1.3.5](https://github.com/karmaresearch/vlog/releases/tag/v1.3.5) that contains commit [ca0669424963765d08a63a29a0d89e27cf33ef51](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51). Therefore, experiments can be reproduced without building `vlog-java.jar` locally, and on Windows OS, in adition to Linux and MacOS.

For [Rulewerk](https://github.com/knowsys/rulewerk) version `0.8.0` (or higher), one can simply update [code-eval-datalog-arithmetic/pom.xml](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/pom.xml):

    		<rulewerk.version>[version >= 0.8.0]</rulewerk.version>

Then, the instructions [1-3](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/BUILDING-EVAL-JAR_README.md#instructions-for-building-evaluation-jar) can be executed to build the evaluation jar.

