| ![alt text][logo] | Integration & Securite Systeme |
| ------------- |:-------------:|

# Cybionet - Ugly Codes Division

## REQUIRED

The `majserver.sh` script does not require any additional packages to work.


<br>

## INSTALLATION

1. Download files from this repository directly with git or via https.
   ```bash
   wget -o majserver.zip https://github.com/cybiohub/sc_majserver/archive/refs/heads/main.zip
   ```

2. Unzip the zip file.
   ```bash
   unzip majserver.zip
   ```

3. Deploy the executable of the `majserver.sh` script.
   ```bash
   cp ./bin/majserver.sh /usr/bin/
   chown root:root /usr/bin/majserver.sh
   chmod 500 /usr/bin/majserver.sh
   ```

4. Copy the autocomplete file (optional).
   ```bash
   cp ./autocomplete/majserver /etc/bash_completion.d/
   ```

5. Voilà! Enjoy!

---
[logo]: ./md/logo.png "Cybionet"
