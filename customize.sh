SKIPUNZIP=1
POSTFSDATA=true
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true
mkdir -p /data/local/tmp/openssl
export TMPDIR=/data/local/tmp/openssl
mount -o remount -o rw /
unzip -o "${ZIPFILE}" -d "${MODPATH}"
tree ${MODPATH}
cd ${MODPATH}/openssl/
chmod +x ${MODPATH}/*.sh
chmod 755 ${MODPATH}/openssl/*
./openssl version 2>&1
old_hash=$(./openssl x509 -subject_hash_old -in /sdcard/Android/data/com.reqable.android/files/certificate/reqable-root.crt |sed -n 1p 2>&1 )
mkdir -p /storage/emulated/0/Download/Reqable/
cp -rv /sdcard/Android/data/com.reqable.android/files/certificate/reqable-root.crt /storage/emulated/0/Download/Reqable/$old_hash.0 
cp -rv /storage/emulated/0/Download/Reqable/$old_hash.0 /system/etc/security/cacerts/
mkdir -p ${MODPATH}/system/etc/security/cacerts/
cp -rv /storage/emulated/0/Download/Reqable/$old_hash.0 ${MODPATH}/system/etc/security/cacerts/
chmod 644 /system/etc/security/cacerts/$old_hash.0 ${MODPATH}/system/etc/security/cacerts/$old_hash.0