#!/bin/sh

DATA_DIR="${DATA_DIR:-/data}"
DEST_DIR="${DEST_DIR:-/out}"

cd "${DATA_DIR}" || exit 1

rsync -arv "${DATA_DIR}/" "${DEST_DIR}"

echo "setting permissions on ${DEST_DIR}"
chmod -R 777 "${DEST_DIR}"

tmp="$(mktemp)"

find . -type f > "$tmp"
while IFS= read -r f; do
    # only envsubst non script files
    if ! [ "$(head -n 1 "$f" | cut -c -2)" = "#!" ]; then
        of="${DEST_DIR}${f#?}"
        echo "envsubst $f into $of..."
        envsubst < "$f" > "$of"
    fi
done < "$tmp"

rm -f "${tmp}"

echo "done deploying"

printf "\n\n"

ls -lah "${DEST_DIR}"

printf "\n\n"

tree -up "${DEST_DIR}"

printf "\n\n"

while true; do
    echo "sleeping..."
    sleep 300
done
