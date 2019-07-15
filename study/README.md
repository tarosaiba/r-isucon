# Study Study Study

# Set up

## vagrant up

* 以下のフォルダに移動して、`vagrant up`

```
$ cd ./provisioning/ansible
$ vagrant up
```

* provisioning で ansibleが必要なので、host(私はmac)で ansibleをinstall

```
$ brew install ansible
```

```
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    default: Running ansible-playbook...
The Ansible software could not be found! Please verify
that Ansible is correctly installed on your host system.

If you haven't installed Ansible yet, please install Ansible
on your host system. Vagrant can't do this for you in a safe and
automated way.
Please check https://docs.ansible.com for more information.
```


* 以下のroleはdockerであげるのでskipしています

```
diff --git a/provisioning/ansible/setup-web.yaml b/provisioning/ansible/setup-web.yaml
index bca4f44..d67b189 100644
--- a/provisioning/ansible/setup-web.yaml
+++ b/provisioning/ansible/setup-web.yaml
@@ -11,5 +11,5 @@
     - role: golang
     - role: nodejs
     - role: java
-    - role: web
+#   - role: web
```

## web app up

* vagrant ssh

```
$ vagrant ssh
```

### docker install

* docker instll → TODO: Ansibleに加える
    - https://github.com/NaturalHistoryMuseum/scratchpads2/wiki/Install-Docker-and-Docker-Compose-(Centos-7)

```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo systemctl start docker.service
sudo systemctl enable docker.service
```

* docker 確認

```
docker run --rm hello-world
```


### docker-compose install

* docker-composeをinstall

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

```
[vagrant@localhost ~]$ sudo cat /etc/profile.d/docker-compose
export PATH=$PATH:/usr/local/bin
```

### git clone

* go のとこで

```
sudo su - isucon
go get github.com/recruit-tech/r-isucon
```

```
git clone https://github.com/recruit-tech/r-isucon.git
```

### mysql を stop

```
systemctl stop mysqld.service
```

### docker-compose up

* docker up
```
docker-compose up -d
```

* 以下にアクセス
``
http://192.168.33.10:3000
```


## bench

* python 3 install して、`python3`でたたけるようにしておく
* go dep install しておく
    - `curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh`
    - `export PATH=$PATH:~/go/bin/`

```
cd bench
make data
make build
make run
```

* 少しするとタイムアウトしちゃう


## メモ
* 以下 Ansible化したい
    * docker install
    * go get
    * python3 install
    * go dep install

