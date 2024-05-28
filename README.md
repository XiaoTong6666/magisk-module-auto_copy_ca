# magisk-module-auto_copy_ca
用于自动复制reqable-app的ca证书（然鹅这是个失败的作品
具体为啥失败我也不清楚，但是证书文件确实到了```/system/etc/security/cacerts/```权限也是644，小黄鸟就是提示未安装证书

以下是customize.sh（安装模块时候执行的脚本）
```
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
```

那个openssl是我用staticx打包成的静态可执行（其实就是自解压然），因为依赖临时目录所以创建和声明了临时目录的变量，这个临时目录变量关闭的时候还他妈会删该目录所以文件的，我当时随便用了$MAGISKTMP，看保存的log害怕极了，还好重要文件都是只读的，不然真寄了（/debug_ramdisk寄不寄不知道，但是TMPDIR声明到/可能真得寄）
