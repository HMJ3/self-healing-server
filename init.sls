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

enable_beacon:
  module.run:
    - name: beacons.add
    - beacon_module: ps
    - m_name: nginx
    - processes:
        nginx:
          - cmd: nginx
          - full: True
    - require:
      - file: /etc/salt/minion.d/beacons.conf

save_beacons:
  module.run:
    - name: beacons.save
    - require:
      - module: enable_beacon
