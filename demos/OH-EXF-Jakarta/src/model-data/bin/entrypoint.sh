#!/bin/sh

DATA_DIR="${DATA_DIR:-/data}"
DEST_DIR="${DEST_DIR:-/out}"

rm -f "${DEST_DIR}/models/.download-complete"

cd "${DATA_DIR}" || exit 1

rsync -arv "${DATA_DIR}/" "${DEST_DIR}"

echo "setting permissions on ${DEST_DIR}"
chmod -R 777 "${DEST_DIR}"

touch "${DEST_DIR}/models/.download-complete"

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
