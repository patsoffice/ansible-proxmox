#!/bin/bash

set -euo pipefail

OWNERSHIP=/opt/etc/ownership.json

if [ ! -f ${OWNERSHIP} ]; then
  echo "ownership file, ${OWNERSHIP}, does not exist"
  exit 1
fi

for row in $( cat ${OWNERSHIP} | jq -r '.[] | @base64' ); do
  ACL_USER=$(echo ${row} | base64 --decode | jq -r '.acl_user // ""' )
  ACL_USER_PERMS=$(echo ${row} | base64 --decode | jq -r '.acl_user_perms // "rwX"' )
  ACL_GROUP=$(echo ${row} | base64 --decode | jq -r '.acl_group // ""' )
  ACL_GROUP_PERMS=$(echo ${row} | base64 --decode | jq -r '.acl_group_perms // "rwX"' )
  UNIX_USER=$(echo ${row} | base64 --decode | jq -r '.unix_user // ""' )
  UNIX_GROUP=$(echo ${row} | base64 --decode | jq -r '.unix_group // ""' )
  UNIX_PERMS_DIR=$(echo ${row} | base64 --decode | jq -r '.unix_perms_dir // "0755"' )
  UNIX_PERMS_FILE=$(echo ${row} | base64 --decode | jq -r '.unix_perms_file // "0644"' )
  PATH_NAME=$(echo ${row} | base64 --decode | jq -r '.path' )

  if [[ -n ${ACL_USER} || -n ${ACL_GROUP} || -n ${PATH_NAME} ]]; then
    setfacl -Rm "u:${ACL_USER}:${ACL_USER_PERMS},g:${ACL_GROUP}:${ACL_GROUP_PERMS}" "${PATH_NAME}"
    setfacl -Rdm "u:${ACL_USER}:${ACL_USER_PERMS},g:${ACL_GROUP}:${ACL_GROUP_PERMS}" "${PATH_NAME}"
  fi

  if [[ -n ${UNIX_USER} || -n ${UNIX_GROUP} || -n ${PATH_NAME} ]]; then
    find "${PATH_NAME}" \( \! -user "${UNIX_USER}" -o \! -group "${UNIX_GROUP}" \) -print0 | xargs -r -n 10 -0 chown "${UNIX_USER}:${UNIX_GROUP}"
    find "${PATH_NAME}" \( -type d -a \! -perm "${UNIX_PERMS_DIR}" \) -print0 | xargs -r -n 10 -0 chmod "${UNIX_PERMS_DIR}"
    find "${PATH_NAME}" \( -type f -a \! -perm "${UNIX_PERMS_FILE}" \) -print0 | xargs -r -n 10 -0 chmod "${UNIX_PERMS_FILE}"
  fi
done
