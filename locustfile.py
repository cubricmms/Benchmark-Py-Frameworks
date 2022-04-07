from locust import HttpUser, task

class DjangoUser(HttpUser):
    @task
    def ping(self):
        self.client.get("/")
