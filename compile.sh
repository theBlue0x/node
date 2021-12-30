#!/bin/sh

if [ -x jdk/bin/java ]; then
    JAVA=./jdk/bin/java
    JAVAC=./jdk/bin/javac
    JAR=./jdk/bin/jar
else
    JAVA=java
    JAVAC=javac
    JAR=jar
fi

PATHSEP=":"
if [ "$OSTYPE" = "cygwin" ] ; then
PATHSEP=";"
fi

CP="lib/*${PATHSEP}classes${PATHSEP}javafx-sdk/lib/*"
SP=src/java/
APPLICATION="Blue0x"

/bin/rm -f ${APPLICATION}.jar
/bin/rm -f ${APPLICATION}service.jar
/bin/rm -rf classes
/bin/mkdir -p classes/

echo "compiling core..."
find src/java/nxt/ -name "*.java" > sources.tmp
${JAVAC} -encoding utf8 -sourcepath "${SP}" -classpath "${CP}" -d classes/ @sources.tmp || exit 1
echo "core class files compiled successfully"

rm -f sources.tmp

echo "compilation done"
