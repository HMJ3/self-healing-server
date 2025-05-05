{% set minion_id = data['id'] %}
{% if data['nginx']['running'] == False %}

restart_nginx:
  local.cmd.run:
    - tgt: {{ minion_id }}
    - arg:
      - systemctl restart nginx
    - kwarg:
        timeout: 10

log_restart:
  local.cmd.run:
    - tgt: {{ minion_id }}
    - arg:
      - logger "Nginx stopped and was automatically restarted by Salt master"

{% endif %}
