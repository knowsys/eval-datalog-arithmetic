Project [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) uses the `0.8.0-SNAPSHOT` version of `rulewek-parser` and `rulewerk-vlog` [Rulewerk](https://github.com/knowsys/rulewerk)  modules, as it can be seen in the [pom.xml](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/code-eval-datalog-arithmetic/pom.xml) file. In turn, `rulewerk-vlog` was used with a locally built `vlog-java.jar` from the [VLog](https://github.com/karmaresearch/vlog) master branch at commit tag [ca0669424963765d08a63a29a0d89e27cf33ef51](https://github.com/karmaresearch/vlog/commit/ca0669424963765d08a63a29a0d89e27cf33ef51). 

To obtain these dependencies, one can locally clone [Rulewerk](https://github.com/knowsys/rulewerk) and run the attached [script](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the parent folder, in order to build it with the `vlog-java.jar` dependency at this specific commit tag. This script is a modified version of a modified version of the script [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh) that is used to build [Rulewerk](https://github.com/knowsys/rulewerk) with a specific version of [VLog](https://github.com/karmaresearch/vlog) (more details [here](https://github.com/knowsys/rulewerk#installation)).

## Building evaluation project instructions
* On a Linux or macOS system, make sure you have Java 1.8 or above and Maven installed, as well as libstdc++-v3.4.22 or above for Linux, or macOS 10.14 or above 
* Clone [Rulewerk](https://github.com/knowsys/rulewerk) and use version `0.8.0-SNAPSHOT` or above.
* Copy [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) in the [Rulewerk](https://github.com/knowsys/rulewerk) parent directory (same level as [build-vlog-library.sh](https://github.com/knowsys/rulewerk/blob/master/build-vlog-library.sh)).
* Run [script build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh](https://github.com/knowsys/eval-datalog-arithmetic/blob/main/build-vlog-library-ca0669424963765d08a63a29a0d89e27cf33ef51.sh) (or run the instructions manually).
* Run `mvn install`. This will build the `rulewek-parser` and `rulewerk-vlog` modules in your local Maven repository
* Use the dependencies built in the previous step in the [eval-datalog-arithmetic](https://github.com/knowsys/eval-datalog-arithmetic/tree/main/code-eval-datalog-arithmetic) to build Java Maven project.
* Run `Main.java` or build an executable jar.




