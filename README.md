# Self-Healing-Server (SaltStack Module)

This SaltStack module automates the setup and monitoring of an nginx service.
It installs and configures nginx, sets up a Salt beacon to monitor its status.
It uses Salt reactor to automatically restart nginx if it stops.

**File structure**
.
├── init.sls
├── LICENSE
├── reactor
│   ├── reactor.conf
│   └── recovery.sls
├── README.md
└── services
    └── nginx
        ├── beacons.conf
        ├── index.html
        └── nginx.conf

## Setup

**1. Clone the repository**

<pre>
$ git clone https://github.com/your-username/self-healing-server.git
$ cd self-healing-server
</pre>

**2. Move the reactor configuration file**

<pre>
$ sudo mv reactor/reactor.conf /etc/salt/master.d/
</pre>

**3. Restart the Salt master to apply changes**

<pre>
$ sudo systemctl restart salt-master.service
</pre

**4. Run the Salt state on your minions**

<pre>
$ sudo salt '*' state.apply self-healing-server
</pre
