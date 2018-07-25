#!/bin/bash
# run as root 
# Changed code to remove the 'head -1' as per the suggestion in comment.
JAVA_VERSION=`java -version 2>&1 | awk 'NR==1{ gsub(/"/,""); print $3 }'`
# export JAVA_VERSION
echo $JAVA_VERSION
echo 'jdk'$JAVA_VERSION'.jdk'
rm -rfv /Library/Java/JavaVirtualMachines/jdk$JAVA_VERSION.jdk
rm -rfv /Library/PreferencePanes/JavaControlPanel.prefPane
rm -rfv /Library/Internet/Plug-Ins/JavaAppletPlugin.plugin
rm -rfv /Library/LaunchAgents/com.oracle.java.Java-Updater.plist
rm -rfv /Library/PrivilegedHelperTools/com.oracle.java.JavaUpdateHelper
rm -rfv /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist
rm -rfv /Library/Preferences/com.oracle.java.Helper-Tool.plist
