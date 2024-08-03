![alt text][logo]

# Cybionet - Ugly Codes Division

## REQUIRED

The `majserver.sh` script does not require any additional packages to work.


<br>

## INSTALLATION

1. Download files from this repository directly with git or via https.
   ```bash
   git clone https://github.com/cybiohub/sc_majserver.git
   ```

2. Deploy the executable of the `majserver.sh` script.
   ```bash
   cp ./bin/majserver.sh /usr/bin/
   chown root:root /usr/bin/majserver.sh
   chmod 500 /usr/bin/majserver.sh
   ```

3. Copy the autocomplete file (optional).
   ```bash
   cp ./autocomplete/majserver /etc/bash_completion.d/
   ```

4. Voilà! Enjoy!

---
[logo]: ./md/logo.png "Cybionet"
