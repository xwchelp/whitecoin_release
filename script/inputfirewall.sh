#!/usr/bin/env bash


systemctl enable firewalld
systemctl start firewalld 
systemctl status firewalld

firewall-cmd --zone=public --add-port=15814-15815/tcp --permanent
firewall-cmd --zone=public --add-port=25070-25701/tcp --permanent

firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='2.82.239.33' drop"

firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='212.125.247.58' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='180.141.36.159' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='104.238.173.54' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='200.68.142.32' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='78.94.80.14' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.180.44.129' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='79.173.127.79' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='185.82.203.241' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='212.125.247.42' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='213.55.220.73' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='194.3.233.46' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='204.16.247.191' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='200.68.142.77' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='117.140.147.68' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='123.8.187.211' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='119.123.30.44' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.244.155.116' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='113.234.43.169' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='84.151.163.238' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='194.35.233.46' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='178.63.60.7' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.112.42.140' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='113.249.197.254' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.75.125.85' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='196.52.2.35' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='124.154.83.114' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='112.236.103.218' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='91.121.110.119' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.52.245.255' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='24.251.224.32' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='126.26.34.17' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='78.46.75.182' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.75.163.155' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.104.203.163' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='69.132.81.225' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='91.121.163.64' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='112.74.177.207' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='111.198.227.8' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='111.193.230.246' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='124.101.163.231' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='46.4.115.247' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.74.4.101' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='101.80.166.40' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='87.191.137.102' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.90.121.214' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.75.85.12' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='73.78.234.84' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='120.77.156.139' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='93.177.72.222' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='47.104.234.126' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='120.228.92.167' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='221.122.37.73' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='72.216.153.137' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='86.83.227.196' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv6' source address='2a01:4f8:141:13a5::2' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv6' source address='2600:8800:1503:cb00:8daa:ae32:3527:bfab' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='114.248.65.168' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='114.156.102.91' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='123.117.107.117' drop"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='172.83.40.21' drop"

firewall-cmd --zone=public --change-interface=eth0
firewall-cmd --reload
firewall-cmd --list-all

