# Create VM with ubuntu cloud images and uvtool

```
$ sudo apt -y install uvtool
$ uvt-simplestreams-libvirt sync release=xenial
$ source vitrage.rc
$ vitrage-create
$ vitrage-ssh
```

See https://help.ubuntu.com/lts/serverguide/cloud-images-and-uvtool.html

