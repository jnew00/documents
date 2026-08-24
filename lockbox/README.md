# Lockbox

Right-click a file or folder in Finder, pick **Encrypt with Lockbox**, get a `.enc`
file you can email or drop on a share. Right-click that `.enc` file on the other
machine, pick **Decrypt with Lockbox**, get the original back.

Everything runs through `/usr/bin/openssl` — the LibreSSL that ships with macOS.
Nothing to install, no Homebrew, no admin rights. That matters on a locked-down
work Mac.

## Crypto

AES-256-CBC, key derived with PBKDF2-SHA512 at 600,000 iterations, random salt
per file. The output is stock `openssl enc` format, so it is readable by any
OpenSSL or LibreSSL build, on any OS, forever — even if this repo disappears.

## Install (on each Mac)

    ./build-quick-actions.sh

That writes the two Quick Actions into `~/Library/Services` and refreshes the
Services database. They point at `bin/lockbox` where this repo sits, so keep the
folder put (or re-run the script after moving it).

If the menu items don't show up immediately, log out and back in, or turn them on
in **System Settings → Keyboard → Keyboard Shortcuts → Services → Files and Folders**.

## Using it

Right-click in Finder → **Quick Actions** → *Encrypt with Lockbox* / *Decrypt with Lockbox*.
Multiple items can be selected at once; you type the passphrase once for the batch.

- A file becomes `report.pdf.enc`
- A folder becomes `MyFolder.tar.gz.enc` (tarred and gzipped first)
- Originals are never touched or deleted — delete them yourself when you're happy
- Nothing is ever overwritten; a name collision gets `-1`, `-2`, and so on

## Skipping the passphrase prompt

    bin/lockbox setkey      # store one passphrase in the login Keychain
    bin/lockbox forgetkey   # go back to prompting every time

With a key stored, encrypt and decrypt run without asking. Do this on your own Mac
if you like; think twice about doing it on the work machine.

## CLI

    bin/lockbox lock   file-or-folder [more...]
    bin/lockbox unlock file.enc [more...]

`LOCKBOX_PASS` in the environment overrides both the Keychain and the prompt,
which is what makes it scriptable.

## Decrypting without any of this installed

`decrypt-anywhere.sh` in this repo is a single self-contained file — copy it next
to the `.enc` and run it. Or skip it entirely and use openssl directly:

    # a file
    openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -md sha512 \
      -in report.pdf.enc -out report.pdf

    # a folder
    openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -md sha512 \
      -in MyFolder.tar.gz.enc -out MyFolder.tar.gz && tar -xzf MyFolder.tar.gz

## Caveats

- The passphrase is the whole security model. Send it over a different channel
  than the file — text it, don't email it alongside.
- CBC gives you confidentiality, not authentication. Nobody can read the file,
  but a determined attacker could corrupt it without you getting a clean error.
  Fine for moving your own work between two machines; not a substitute for
  signed, authenticated transport if the threat model is real.
- Filenames are not encrypted. `Q3-layoffs.xlsx.enc` still says what it is.
