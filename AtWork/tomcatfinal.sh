#!/bin/bash
mkdir /opt/tomcat/
groupadd tomcat
useradd -g tomcat -d /opt/tomcat tomcat

wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.28/bin/apache-tomcat-8.5.28.tar.gz
tar -xzvf apache-tomcat-8.5.28.tar.gz
mv apache-tomcat-8.5.28/* /opt/tomcat/

#Add Default Path to .bashrc
chown tomcat:tomcat /opt/tomcat/
echo "export CATALINA_HOME=/opt/tomcat" >> ~/.bashrc
source ~/.bashrc

#for check
echo $CATALINA_HOME
#chmod u+x /opt/tomcat/bin/*.sh
#for start tomcat server
/opt/tomcat/bin/startup.sh
#for stop tomcat server
/opt/tomcat/bin/shutdown.sh

#second Part of Configuration
#Adding Role and User in the tomcat-users.xml
echo "Please enter username"
read user
echo "Please type the password for manager-gui"
read pass
sed -i 's/<\/tomcat-users>//g' /opt/tomcat/conf/tomcat-users.xml
echo "<role rolename=\"manager-gui\"/>
  <role rolename=\"admin-gui\"/>
  <user username=\"$user\" password=\"$pass\" roles=\"manager-gui,admin-gui,manager-script\"/>
</tomcat-users>
" >>/opt/tomcat/conf/tomcat-users.xml

#Comment one line /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i 's/<Valve/<!-- <Valve/g' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i 's/1" \/>/1" \/> -->/' /opt/tomcat/webapps/manager/META-INF/context.xml

#Comment one line /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i 's/<Valve/<!-- <Valve/g' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i 's/1" \/>/1" \/> -->/' /opt/tomcat/webapps/host-manager/META-INF/context.xml

#for start tomcat server
/opt/tomcat/bin/startup.sh
#for stop tomcat server
/opt/tomcat/bin/shutdown.sh


#TOMCAT as service
sudo touch /etc/init.d/tomcat
sudo chmod 755 /etc/init.d/tomcat

sudo echo "#!/bin/bash
### BEGIN INIT INFO
# Provides:          tomcat
# Required-Start:    \$local_fs \$remote_fs \$network \$syslog
# Required-Stop:     \$local_fs \$remote_fs \$network \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Startup script for Tomcat server
# Description:       Tomcat is a high-throughput distributed messaging system.
### END INIT INFO
#
# /etc/init.d/tomcat
#
# Startup script for tomcat
#
# chkconfig: 2345 20 80
# description: Starts and stops tomcat

CATALINA_HOME=/opt/tomcat
PATH=\$PATH:\$CATALINA_HOME/bin

# See how we were called.
case \"\$1\" in
  start)
        # Start daemon.

         pids=\$(ps ax | grep -i 'org.apache.catalina.startup.Bootstrap' | grep -v grep | awk '{print \$1}')

        if [ -n \"\$pids\" ]
        then
          echo \"Tomcat is Running :\$pids\"
          exit 1
        else
          echo \"Starting Tomcat\"
          \$CATALINA_HOME/bin/startup.sh
        fi
        ;;
  stop)
        # Stop daemons.

        PIDS=\$(ps ax | grep -i 'org.apache.catalina.startup.Bootstrap' | grep -v grep | awk '{print \$1}')

        if [ -z \"\$PIDS\" ]; then
          echo \"No tomcat server to stop\"
          exit 1
        else
          \$CATALINA_HOME/bin/shutdown.sh
          kill -s TERM \$PIDS
        fi
        ;;
  restart)
        \$0 stop
        sleep 2
        \$0 start
        ;;
  status)
        pid=\`ps ax | grep -i 'org.apache.catalina.startup.Bootstrap' | grep -v grep | awk '{print \$1}'\`
        if [ -n \"\$pid\" ]
          then
          echo \"Tomcat is Running as PID: \$pid\"
        else
          echo \"Tomcat is not Running\"
        fi
        ;;
  *)
        echo \"Usage: \$0 {start|stop|restart|status}\"
        exit 1
esac

exit 0 ">> /etc/init.d/tomcat


#for start tomcat server
sudo service tomcat start

