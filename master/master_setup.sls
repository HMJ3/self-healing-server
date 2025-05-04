# Moves the file to the correct directory 
/etc/salt/master.d/reactor.conf:
  file.managed:
    - source: salt://self-healing-server/master/reactor.conf
    
restart_salt_master:
  service.running:
    - name: salt-master
    - watch:
      - file: /etc/salt/master.d/reactor.conf
