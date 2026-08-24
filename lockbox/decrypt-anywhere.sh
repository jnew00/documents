#!/bin/sh
# Self-contained Lockbox decryptor. No install, no dependencies beyond openssl.
# Copy this next to a .enc file and run:  ./decrypt-anywhere.sh FILE.enc
set -e

[ $# -ge 1 ] || { echo "usage: $0 FILE.enc [more.enc...]" >&2; exit 2; }

OPENSSL=$(command -v openssl || echo /usr/bin/openssl)
[ -x "$OPENSSL" ] || { echo "openssl not found" >&2; exit 1; }

printf 'Passphrase: '
stty -echo 2>/dev/null || true
read -r PASS
stty echo 2>/dev/null || true
printf '\n'

for src in "$@"; do
  case "$src" in
    *.enc) ;;
    *) echo "skipping (not .enc): $src" >&2; continue ;;
  esac
  out=${src%.enc}
  tmp=$(mktemp) || exit 1
  if ! PASS="$PASS" "$OPENSSL" enc -d -aes-256-cbc -pbkdf2 -iter 600000 -md sha512 \
       -in "$src" -out "$tmp" -pass env:PASS 2>/dev/null; then
    rm -f "$tmp"
    echo "failed (wrong passphrase or not a Lockbox file): $src" >&2
    exit 1
  fi
  case "$out" in
    *.tar.gz)
      dir=${out%.tar.gz}
      mkdir -p "$dir"
      tar -xzf "$tmp" -C "$dir"
      rm -f "$tmp"
      # hoist the single top-level dir tar created
      if [ -d "$dir/$(basename "$dir")" ]; then
        mv "$dir/$(basename "$dir")" "$dir.hoist$$" && rmdir "$dir" && mv "$dir.hoist$$" "$dir"
      fi
      echo "decrypted -> $dir/" ;;
    *)
      mv "$tmp" "$out"
      chmod 644 "$out"
      echo "decrypted -> $out" ;;
  esac
done
