#!/bin/sh
# hash_sysfs_edid() simply concatenates the md5 hashes of all connected 
# monitors and hashes them again so that the output is always 32 characters long.
hash_sysfs_edid () {
  edid_hash=""
    for DEVICE in /sys/class/drm/card*-*; do
        [ -e "${DEVICE}/status" ] && grep -q "^connected$" "${DEVICE}/status" || continue
      edid_hash="${edid_hash}"$(md5sum "${DEVICE}/edid" | awk '{print $1}')
	#   echo $DEVICE
	#   echo $(edid-decode ${DEVICE}/edid | grep "Display Product Name")
    done
  echo $(echo "$edid_hash" | md5sum | awk '{print $1}')
}

hash_sysfs_edid