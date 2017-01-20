#!/bin/sh

echo "CATALINA_OPTS=\"-Dadditional.config.locations=/infra/conf/cynergy-config.xml -Djava.awt.headless=true -Dco.unpackwars=true -Dcatalina.logs=/infra/logs/tomcat -Xdebug -Xrunjdwp:transport=dt_socket,address=localhost:50101,server=y,suspend=n -Dcom.sun.jndi.ldap.read.timeout=60000 -Dcom.sun.jndi.ldap.connect.pool.timeout=30000 -Dcom.sun.jndi.ldap.connect.timeout=10000 \"" >> /etc/default/tomcat7
echo "JAVA_OPTS=\"-d64 -XX:MaxPermSize=512m -Xmx2600M -Xms2600M -Xmn750m -Dsun.rmi.dgc.server.gcInterval=600000 -Dsun.rmi.dgc.client.gcInterval=60000 -XX:+UseParallelGC -verbose:gc -Xloggc:/infra/logs/tomcat/gc.log -Dnetworkaddress.cache.ttl=60 -Dsun.net.inetaddr.ttl=60 -Duser.timezone=America/New_York -javaagent:/usr/share/appdynamics/javaagent.jar\"" >> /etc/default/tomcat7

echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/default/tomcat7

freshclam -d
clamd &

service tomcat7 start

sleep 10
tail -f /infra/logs/all.log -f /var/log/tomcat7/localhost.*.log
