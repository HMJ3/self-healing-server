nginx:
  pkg.installed

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://self-healing-server/services/nginx/nginx.conf

/var/www/html/index.nginx-debian.html:
  file.managed:
    - source: salt://self-healing-server/services/nginx/index.html

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /var/www/html/index.nginx-debian.html

#Beacon config
/etc/salt/minion.d/beacons.conf:
  file.managed:
    - source: salt://self-healing-server/services/nginx/beacons.conf
    - require:
      - pkg: nginx

install_service_beacon:
  file.managed:
    - name: /etc/salt/minion.d/beacons.conf
    - source: salt://self-healing-server/services/nginx/beacons.conf
    - makedirs: True

restart_minion_service:
  service.running:
    - name: salt-minion
    - watch:
      - file: install_service_beacon

# Add restart salt-minion.service to this script!!!!

