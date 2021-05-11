Project [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) uses the `0.8.0-SNAPSHOT` version of `rulewek-parser` and `rulewerk-vlog` [Rulewerk](https://github.com/knowsys/rulewerk)  modules, as it can be seen in the [pom.xml](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/pom.xml) file. In our experiments, `rulewerk-vlog` was used with a locally built `vlog-java.jar`dependency from the [VLog](https://github.com/karmaresearch/vlog) master branch at commit tag [ca0669424963765d08a63a29a0d89e27cf33ef51](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51). 

To obtain these dependencies, one can locally clone [Rulewerk](https://github.com/knowsys/rulewerk) and run the attached [script](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh), in order to build it with the `vlog-java.jar` dependency at this specific commit tag. This script is a modified version of a modified version of the script [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh) that is used to build [Rulewerk](https://github.com/knowsys/rulewerk) with a snapshot version of [VLog](https://github.com/karmaresearch/vlog) (more details [here](https://github.com/knowsys/rulewerk#installation)).

## Building evaluation project to replicate experiments
* On a Linux or macOS system, make sure you have Java 1.8 or above and Maven installed, as well as libstdc++-v3.4.22 or above for Linux, or macOS 10.14 or above 
* Clone [Rulewerk](https://github.com/knowsys/rulewerk) and use version `0.8.0-SNAPSHOT` or above.
* Increase the version of `vlog-java` (in `rulewerk-vlog/pom.xml`, `<karmaresearch.vlog.version>` property).
* Copy [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the `rulewerk` directory (same level as [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh), the parent directory of `rulewek-parser` and `rulewerk-vlog`).
* Run [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the `rulewerk` directory (or run the instructions in this file manually).
* Run `mvn install` in the `rulewerk` directory. This will build  and install the `rulewek-parser` and `rulewerk-vlog` modules in your local Maven repository.
* You can now use the dependencies installed in the previous step to build the [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) Java Maven project. Run `mvn package` in `code-eval-datalog-arithmetic` directory.
* You will now find an executable jar named `code-eval-datalog-arithmetic.jar` in `code-eval-datalog-arithmetic/target` directory. 
* Run `code-eval-datalog-arithmetic.jar` as shown [here](https://github.com/knowsys/eval-datalog-arithmetic#toolchain) (Alternatively, run Main.java from your prefered IDE).

## Building evaluation project for Rulewerk version `0.8.0` or higher
This evaluation was conducted on a development version of [Rulewerk](https://github.com/knowsys/rulewerk)(0.8.0-SNAPSHOT) and of [VLog](https://github.com/karmaresearch/vlog) (commit `ca0669424963765d08a63a29a0d89e27cf33ef51`). After the release of [Rulewerk](https://github.com/knowsys/rulewerk) `0.8.0` (or higher), one can simply update [code-eval-datalog-arithmetic/pom.xml](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/pom.xml):

    		<rulewerk.version>0.8.0</rulewerk.version>



