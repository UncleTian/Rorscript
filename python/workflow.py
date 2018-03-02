#!/usr/bin/env python3
# -*- coding=utf-8 -*-
import os
import shlex
import subprocess

print("Workflow")
JMX_PORT = '6990'

java_opts = '-Djava.awt.headless = true - DPROCESSID = WORKFLOW_APP '
java_opts = java_opts + '-Xmx1024m - Xms512m - XX: MaxMetaspace = 202m '
java_opts = java_opts + '-Dhazelcast.config = %~dp0\props\hazelcast.xml '
java_opts = java_opts + '-Dlogback.configurationFile = %~dp0\workflow\config\logback.xml '
java_opts = java_opts + \
    '-Djava.util.logging.config.file = %~dp0\workflow\config\logging.properties '
java_opts = java_opts + '-XX: +HeapDumpOnOutOfMemoryError'
java_opts = java_opts + '-Dcom.sun.management.jmxremote.authenticate = false '
java_opts = java_opts + \
            '-Dcom.sun.management.jmxremote.ssl = false - Djava.rmi.server.hostname = localhost - Dcom.sun.management.jmxremote.port = ' + JMX_PORT

java_opts = java_opts + \
    ' -Xdebug - Xnoagent - Xrunjdwp: transport = dt_socket, address = 8700, server = y, suspend = n '

command = 'java ' + java_opts + '-jar ~dp0\workflow.jar'
print(command)


if __name__ == "__main__":
    os.system("dir")
    subprocess.run(shlex.split(command))

