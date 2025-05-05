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
    - makedirs: True
    - require:
      - pkg: nginx
