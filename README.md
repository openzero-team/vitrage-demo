# Create VM with ubuntu cloud images and uvtool

In host

```
$ sudo apt -y install uvtool
$ uvt-simplestreams-libvirt sync release=trusty
$ source vitrage.rc
$ vitrage-create
$ vitrage-ssh
```

In guest

```
$ curl -L https://raw.githubusercontent.com/openzero-zte/vitrage-demo/master/vitrage-install|sudo bash
```

See also https://help.ubuntu.com/lts/serverguide/cloud-images-and-uvtool.html
