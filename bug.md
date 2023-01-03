# replication steps

1. Go to https://console.equinix.com and select "create a server"

2. Choose the Spot-Market

3. Use the location: `Amsterdam` and machine size: `m3.small`

4. choose `Ubuntu 22.04` as the OS

5. Deploy as one-time bid

6. configure -> Add optional user data

7. use the yaml from: https://metal.equinix.com/developers/docs/server-metadata/user-data/

    ```yaml
    #cloud-config
    package_update: true
    packages:
      - nginx
    ```

8. click `apply these settings`

9. set hostname

10. click `deploy`

11. watch the process via ssh with 

    ```bash 
    ssh -i ~/.ssh/$user root@145.40.68.211 \
        sudo tail -f /var/log/cloud-init-output.log
    ```

12. See that it hangs on:

    ```bash
    ing new version of config file /etc/ubuntu-advantage/help_data.yaml ...
    ing new version of config file /etc/ubuntu-advantage/uaclient.conf ...
     symlink /etc/systemd/system/multi-user.target.wants/ubuntu-advantage.service → /lib/systemd/system/ubuntu-advantage.service.
    ```

13. See that apt is locked

    ```bash
    root@metal:~# sudo apt-get upgrade
    E: Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 2542 (apt-get)
    N: Be aware that removing the lock file is not a solution and may break your system.
    E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
    root@metal:~# 
    ```

13. Motd shows

    ```bash
    Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-33-generic x86_64)

     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/advantage

      System information as of Fri Oct  7 12:50:35 UTC 2022

      System load:            0.09423828125
      Usage of /:             1.0% of 437.62GB
      Memory usage:           1%
      Swap usage:             0%
      Temperature:            54.0 C
      Processes:              293
      Users logged in:        0
      IPv4 address for bond0: 145.40.68.211
      IPv6 address for bond0: 2604:1380:4601:a300::1


    120 updates can be applied immediately.
    69 of these updates are standard security updates.
    To see these additional updates run: apt list --upgradable


    *** System restart required ***
    root@metal:~# 
    ```



