#!/bin/sh

skip_desktop=1

help()
{
    echo "Parameters:"
    echo
    echo "  --skip-desktop : Do not compile desktop classes."
    exit
}

while [ "$1" != "" ]; do
    case $1 in
        --skip-desktop )   skip_desktop=1
                           ;;
        * )                help
                           ;;
    esac
    shift
done

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

if [ $skip_desktop -eq 0 ]; then
    echo "compiling desktop..."
    find src/java/nxtdesktop/ -name "*.java" > sources.tmp
    ${JAVAC} -encoding utf8 -sourcepath "${SP}" -classpath "${CP}" -d classes/ @sources.tmp
    if [ $? -eq 0 ]; then
        echo "desktop class files compiled successfully"
    else
        echo "working..."
    fi
fi

rm -f sources.tmp

echo "compilation done"
