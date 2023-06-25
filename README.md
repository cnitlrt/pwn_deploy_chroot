# How to Use
```
python initialize.py
sudo docker-compose up -d
```
# 新增
自动上题,将题目放入到bin目录，然后执行下面的命令
```
python3 initialize.py
python3 auto_test.py ip port flags_path bin_path
```
其中ip是网站的ip地址，port是网站的port,`flags_path`是flags.txt存放的目录，这里是当前目录，`bin_path`是bin目录的绝对路径,例如
```
python3 auto_test.py 127.0.0.1 8000 ./flags.txt /home/ubuntu/pwn_deploy_chroot/bin
```
