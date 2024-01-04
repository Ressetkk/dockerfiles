#!/usr/bin/dumb-init /bin/sh

if [[ -z "$JAVA_OPTS" ]]; then
    JAVA_OPTS="-Xms2G -Xmx2G"
fi

if [[ "$EULA" == "true" ]]; then
    if [[ ! -e "eula.txt" ]]; then
        echo "eula=true" > eula.txt
    fi
fi

exec "java $JAVA_OPTS -jar /paper.jar --nogui $PAPER_OPTS"