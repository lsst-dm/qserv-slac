import requests
url = "http://lsst-qserv-master01:25681/replication/qserv/worker/status"
data = requests.get(url).json()
for item in data["status"].items():
    worker = item[0]
    info = item[1]
    num_tasks = info["info"]["processor"]["queries"]["blend_scheduler"]["num_tasks_in_queue"]
    print(worker, num_tasks)
