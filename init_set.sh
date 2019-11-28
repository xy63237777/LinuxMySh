touch /usr/lib/systemd/system/rc-local.service

echo "[Unit]
Description=\"/etc/rc.local Compatibility\" 

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardInput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/rc-local.service

touch /etc/rc.local

echo "#!/bin/sh
# /etc/rc.local
if test -d /etc/rc.local.d; then
    for rcscript in /etc/rc.local.d/*.sh; do
        test -r "${rcscript}" && sh ${rcscript}
    done
    unset rcscript
fi" > /etc/rc.local
chmod a+x /etc/rc.local
mkdir /etc/rc.local.d
systemctl enable rc-local
