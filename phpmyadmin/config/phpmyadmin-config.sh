#!/bin/bash

cat <<'EOM'
<?php
$i = 0;

$i++;
$cfg['Servers'][$i]['verbose'] = 'Docker MySQL';
$cfg['Servers'][$i]['host'] = '172.17.42.1';
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['user'] = '';
$cfg['Servers'][$i]['password'] = '';

$cfg['DefaultLang'] = 'en';
$cfg['DefaultChartset'] = 'utf-8';
$cfg['ServerDefault'] = 1;
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
EOM

secret=$(cat /dev/urandom | head -c 36 | base64)
echo "\$cfg['blowfish_secret'] = '${secret}';"
