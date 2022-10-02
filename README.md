# FinalProject
Вимоги до фінального проекту
Створіть наступну інфраструктуру засобами Devops tools.
1. Написати тераформ темлейт який створює машину з образом Ubuntu 20.04 в одному на вибір хмарному сервісі, відразу встановлює на цій машині: docker, docker-compose, terraform, net-tools, inetutils-traceroute.
2. Створити скрипт або makefile який інсталює образ TeamCity (Jenkins) в docker, та запускає контейнер із TeamCity (Jenkins).
3. Створити terraform скрипт, який піднімав би Azure на Windows Server (Web) і піднімав там базу даних SQL/Postgres/MongoDB.
4. Написати pipeline який:
	1. Копіює репозиторій гіт з усіма скриптами і потрібними файлами для роботи.
	2. Піднімає контейнер із Grafana і Prometheus
	3. Запускає terraform скрипт із завдання 3.
	
5. Створити dashboard у контейнері docker з Grafana та Prometheus для
відстеження рівня використання CPU/RAM/Disk для Windows VM з пункту 3.
6. Створити Grafana алерти у разі якщо використання CPU більше 80%, місця на диску більше 75% Grafana і створити відправку їх на emai/slack/telegram/discord. На вибір. (edited) 
