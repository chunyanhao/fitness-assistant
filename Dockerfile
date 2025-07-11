# 构建一个用于部署 Python Flask 应用的 Docker image。
# 该应用使用 Pipenv 管理依赖，并通过 gunicorn 启动服务
# “slim” 意味着去除了不必要的包，更轻量，适合生产环境
FROM python:3.12-slim
 
WORKDIR /app

RUN pip install pipenv

COPY data/data.csv data/data.csv
COPY ["Pipfile", "Pipfile.lock", "./"]

RUN pipenv install --deploy --ignore-pipfile --system

COPY fitness_assistant .

# 告诉 Docker 这个容器会监听 5000 端口， Flask 或 gunicorn 默认就是监听这个端口
EXPOSE 5000

CMD gunicorn --bind 0.0.0.0:5000 app:app