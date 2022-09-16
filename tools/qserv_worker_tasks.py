import requests
url = "http://127.0.0.1:25081/replication/qserv/worker/status"
data = requests.get(url).json()
for item in data["status"].items():
    worker = item[0]
    info = item[1]
    num_tasks = info["info"]["processor"]["queries"]["blend_scheduler"]["num_tasks_in_queue"]
    print(worker, num_tasks)
