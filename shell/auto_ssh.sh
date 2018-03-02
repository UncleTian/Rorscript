#!/usr/bin/expect -f
# ssh username@host -p port
spawn ssh pi@192.168.1.0 -p 22
expect -re "(P|p)assword:"
send "password\r"
interact
