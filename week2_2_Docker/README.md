# Preparation for container

```sh
docker-compose up -d
docker-compose exec mysql bash
```

# Create Python Environment

```sh
cd /code
python3 -m venv venv # Create the env
source venv/bin/activate # Enter the env
python3 -m pip install --upgrade pip # pip upgrade
pip3 install -r requirements.txt # install library
```

# Excute Python

```python
python run.py
```


# Delete the container

```sh
exit
docker-compose down
```