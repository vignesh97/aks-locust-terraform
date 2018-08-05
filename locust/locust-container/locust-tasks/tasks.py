#!/usr/bin/env python

# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import uuid

from datetime import datetime
from locust import HttpLocust, TaskSet, task


class MetricsTaskSet(TaskSet):
    _deviceid = None

    def on_start(self):
        self._deviceid = str(uuid.uuid4())

    @task(1)
    def testpost(self):
        self.client.post(
            '/testpost', {"deviceid": self._deviceid})

    @task(996)
    def healthcheck(self):
        self.client.get("/healthcheck")

    @task(997)
    def webservice1(self):
        self.client.get("/webservice1")

    @task(998)
    def webservice2(self):
        self.client.get("/webservice2")

    @task(999)
    def webservice3(self):
        self.client.get("/webservice3")


class MetricsLocust(HttpLocust):
    task_set = MetricsTaskSet