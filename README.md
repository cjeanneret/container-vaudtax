# Run VaudTax in a container
## Prerequists
- podman
- buildah

## How to use
Just clone this repository, ensure you have the prerequists, and run:
```Bash
./run.sh
```

This will build and run a container using ```podman build``` and ```podman run```, and
will start automatically VaudTax application.

Il will automatically mount your previous and current taxes in the container, allowing you to access them
in order to import your data.

It uses the default locations, ~/VaudTax<YEAR> and ~/VaudTax<YEAR-1>. For instance, if we're in 2020, it
will create and mount ~/VaudTax2018 and ~/VaudTax2019.

## Why?
Because VaudTax doesn't support other Linux than Ubuntu, and there are people on Fedora, CentOS
and other distro. Providing a container is probably the best way to run that app.

## SELinux
This repository provides a .te for Fedora, CentOS and RHEL. You may compile it and install it. The
provided policy will basically allow container_t to access X (beware, NOT tested on Wayland).

In order to compile and load that policy, please run:
```Bash
$ checkmodule -M -m -o vaudtax.pp vaudtax.te
$ semodule_package -o vaudtax.pp -m vaudtax.mod
$ sudo semodule -i vaudtax.pp
```

This will solve the following AVCs:
```
type=AVC msg=audit(1579630535.776:496): avc:  denied  { write } for  pid=20042 comm="java" name="X0" dev="tmpfs" ino=43290 scontext=system_u:system_r:container_t:s0:c340,c859 tcontext=system_u:object_r:user_tmp_t:s0 tclass=sock_file permissive=0
type=AVC msg=audit(1579637840.311:329): avc:  denied  { write } for  pid=6662 comm="java" name="X0" dev="tmpfs" ino=41654 scontext=system_u:system_r:container_t:s0:c796,c959 tcontext=system_u:object_r:user_tmp_t:s0 tclass=sock_file permissive=1
type=AVC msg=audit(1579637840.311:330): avc:  denied  { connectto } for  pid=6662 comm="java" path="/tmp/.X11-unix/X0" scontext=system_u:system_r:container_t:s0:c796,c959 tcontext=system_u:system_r:xserver_t:s0-s0:c0.c1023 tclass=unix_stream_socket permissive=1
```

You can remove the SELinux module using:
```Bash
$ sudo semodule -r vaudtax
```

### I don't trust your SELinux policy!
If you want to make your own policy, you can set your system to permissive:
```Bash
$ sudo setenforce 0
```
Then run the following command:
```Bash
$ sudo tail -f /var/log/audit/audit.log | grep denied
```
Finally run the container:
```Bash
$ ./run.sh
```

You can then copy/paste the listed AVCs in a file, and create your own policy:
```Bash
$ cat <your-file> | audit2allow -M vaudtax
$ sudo semodule -i vaudtax.pp
$ sudo setenforce 1
```
And Voilà.
