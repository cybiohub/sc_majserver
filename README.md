![alt text][logo]
 
# Majserver
This script is used to update Linux systems (Ubuntu and Debian) with the apt-get command. A very basic script, but which allows you to,

- Speed up the update by forcing the use of IPv4 only.
- Generate an execution log for logging.
- Allows better control for technicians unfamiliar with Linux.
- Prevents the execution of some tasks if a restart of the system is necessary. 


<br>

## INSTALLATION

[Installation procedure](INSTALL.md) 



<br>

# Control
To maintain control over updates in the event of a loss of SSH connection, updates are launched in screen. To resume a session, run this command on the concerned machine:

```bash
screen -r majserver
```


<br>

# Usage

Usage: majserver.sh [options]


```
General options:
    -upd,  [update]		# Download package information from all configured sources.
    -upg,  [upgrade]		# Install the newest versions of all packages currently installed.
    -dupg, [dist-upgrade]	# Upgrade the most important packages, at the expense of those deemed less important.
    -rm,   [autoremove]		# Remove packages that were automatically installed to satisfy dependencies for other packages and are now no longer needed.
    -cln,  [autoclean]		# Clears out the local repository of retrieved package files.
    -chk,  [check]		# Updates the package cache and checks for broken dependencies.
    -dry,  [list]		# Display a list of upgradable packages.
    -log,  [showlog]		# Show log of the program.
    -ver,  [version]		# Show the program version.
```
---
[logo]: ./md/logo.png "Cybionet"
