# ReStaking script - auto claiming and delegating rewards for Rizon Network

1. Download the script from my repository:

```bash
wget https://github.com/5PARM1T/scriptsCosmoSDK/blob/main/restakingRizon.sh
```

2. Give the permissions to this file:

```bash
chmod +x restakingRizon.sh
```

3. Edit this script with your credentials -> change these parameters: DELEGATOR='Your delegator address' ;
VALIDATOR='Your validator address' ;
PASWD='pass phrase from cli' ;
DELAY=3600 #in secs - how often restart the script ;
ACC_NAME=YourWalleName 
 
 ```bash
nano restakingRizon.sh
```
4. Open the screen or tmux session:
 
 ```bash
# tmux new-session -s rizonscript
```
5. Run auto claiming and delegating rewards:

 ```bash
bash restakingRizon.sh
```
6. Enjoy it :)

```bash
.
.
.
```
***RUS***  
Скачиваем скрипт 
```bash
 # wget https://github.com/5PARM1T/scriptsCosmoSDK/blob/main/restakingRizon.sh 
```
Даем нужные разрешения
```bash
 # chmod +x restakingRizon.sh
```
Открываем в nano скачанный файл
```bash
 # nano restakingRizon.sh
```
Редактируем файл внося нужные изменения: измените эти параметры: 
 DELEGATOR = 'Ваш адрес делегата: rizon1........'; 
 VALIDATOR = 'Ваш адрес валидатора: rizonvaloper1.......'; 
 PASWD = 'пароль от cli'; 
 ACCNAME = YourWalleName

# Обновления groot-011
   Создаем отдельное окно в TMUX для запуска скрипта
```bash
    # tmux new-session -s rizonscript
```
   
   Запускаем сам скрипт и расслабляемся
```bash
    # bash restakingRizon.sh
```
