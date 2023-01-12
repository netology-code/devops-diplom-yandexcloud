# создаём сервисный аккаунт, предоставляем роль editor
$ yc iam service-account create --name neto-robot --description "Service account for Netology"

#Создайте авторизованный ключ для вашего сервисного аккаунта и запишите его файл:

$ yc iam key create --service-account-name neto-robot --output key.json

Создайте ключ доступа для сервисного аккаунта:

```
iva@c9:~/Documents/YC $ yc iam access-key create --service-account-name neto-robot
access_key:
  id: ajee50ng7jcav6p2c6oq
  service_account_id: ajegb4hm7vmc8mtflcdq
  created_at: "2022-03-25T23:39:13.295548648Z"
  key_id: YCAJEou5UEaZBnd8uIJte-gcn
secret: YCOX5m-V59haXjhUWAKTWxFDNjwn1nSdZmFAnh0B
```


Узнайте идентификатор сервисного аккаунта по его имени:

```
iva@c9:~/Documents/YC $ yc iam service-account get neto-robot
id: ajegb4hm7vmc8mtflcdq
folder_id: b1gm6im3mcuc36r6kn8s
created_at: "2022-03-25T22:28:10Z"
name: neto-robot
description: Service account for Netology
```
или

```
iva@c9:~/Documents/YC $ yc iam service-account list
+----------------------+------------+
|          ID          |    NAME    |
+----------------------+------------+
| ajegb4hm7vmc8mtflcdq | neto-robot |
+----------------------+------------+
```
Назначьте роль сервисному аккаунту neto-robot, используя его идентификатор:

```
yc resource-manager folder add-access-binding netology \
    --role editor \
    --subject serviceAccount:ajegb4hm7vmc8mtflcdq
```

Параметры командной строки
--access-key STR: Идентификатор ключа доступа
--secret-key STR: Секретный ключ доступа

Переменные окружения
Если какой-либо параметр аутентификации не указан в командной строке, YDB CLI пробует его получить из следующих переменных окружения:

AWS_ACCESS_KEY_ID: Идентификатор ключа доступа
AWS_SECRET_ACCESS_KEY: Секретный ключ доступа

export YC_TOKEN='AQAEA7**************'
export AWS_ACCESS_KEY_ID='YCAJEou5UE*****************'
export AWS_SECRET_ACCESS_KEY='YCOX5m-*************************'

terraform apply -auto-approve

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

internal_ip = {
  "nexus" = tolist([
    "10.2.0.7",
  ])
  "sonarqube" = tolist([
    "10.2.0.11",
  ])
}
nat_ip = {
  "nexus" = tolist([
    "51.250.72.245",
  ])
  "sonarqube" = tolist([
    "51.250.91.60",
  ])
}

ansible-playbook -i inventory/cicd/prod.yml site.yml 

sonar-scanner \
  -Dsonar.projectKey=netology_test \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://51.250.73.167:9000 \
  -Dsonar.login=b80a95958591b000bf6465962193f9f0d99436a7 \
  -Dsonar.coverage.exclusions=fail.py
  
  
PS1='\[\e[38;5;'$prompt_color'm\]\t j\j \u@\h:\w\n'

PS1='\[\033[2;36m\]\u@\h:\[\033[0m\]\[\033[1;34m\]\w\[\033[0m\] \[\033[1;32m\]$(__git_ps1)\[\033[0m\]\$ '


echo -e "$color: \\033[38;5;196mhello\\033[48;5;36mworld\\033[0m"
