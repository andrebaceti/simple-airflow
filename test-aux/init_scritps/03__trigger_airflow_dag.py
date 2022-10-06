import datetime
import time
from airflow_client import client
from pprint import pprint
from airflow_client.client.api import config_api
from airflow_client.client.api import dag_api
from airflow_client.client.api import dag_run_api
from airflow_client.client.model.dag_run import DAGRun
from airflow_client.client.model.dag_state import DagState
from airflow_client.client.model.error import Error

#####################
# Configure airflow #
configuration = client.Configuration(
    host="http://0.0.0.0:8080/airflow/api/v1",
    username='admin', password='admin')
api_client = client.ApiClient(configuration)
######################

# List avaiable Dags #
dag_api_instance = dag_api.DAGApi(api_client)

limit = 100
offset = 0
only_active = True
api_response = dag_api_instance.get_dags(
    limit=limit, offset=offset, only_active=only_active,
    order_by="dag_id")

###########
# Run DAG #
dagrun_api_instance = dag_run_api.DAGRunApi(api_client)
dag_run_id = "dag_run_id_example__%s" % datetime.datetime.now().isoformat()
dag_run = DAGRun(dag_run_id=dag_run_id, conf={
    "parm1": 1, "parm2": 2})

dag_id = "example_python_operator__test_api"
try:
    # Trigger a new DAG run
    api_response = dagrun_api_instance.post_dag_run(dag_id, dag_run)
    pprint(api_response)
except client.ApiException as e:
    print("Exception when calling DAGRunApi->post_dag_run: %s\n" % e)
while True:
    result = dagrun_api_instance.get_dag_run(
        dag_run_id=dag_run_id, dag_id=dag_id)
    print("state:", result["state"])
    time.sleep(1)
