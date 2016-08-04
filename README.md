# Create VM with ubuntu cloud images and uvtool

```
$ sudo apt -y install uvtool
$ uvt-simplestreams-libvirt sync release=xenial
$ uvt-kvm create vitrage
$ uvt-kvm ssh vitrage --insecure
```

See https://help.ubuntu.com/lts/serverguide/cloud-images-and-uvtool.html

