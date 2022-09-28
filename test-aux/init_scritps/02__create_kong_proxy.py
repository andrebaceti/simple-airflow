import requests

template_service = "{api_gateway_url}/services/{service_name}/"
routes_url_template = "{api_gateway_url}/routes/{route_name}/"


api_gateway_url = "http://localhost:8001"
service_name = "airflow"
route_name = "airflow--rote"


temp_service_url = template_service.format(
    api_gateway_url=api_gateway_url,
    service_name=service_name)
payload = {
    'name': service_name,
    'url': "http://airflow-webserver:8080/"}
response_service = requests.put(
    temp_service_url, json=payload).json()


service_id = response_service["id"]
route_url = "/airflow"
route_name = "airflow--route"
strip_path = False
response_routes = requests.put(
    routes_url_template.format(
        api_gateway_url=api_gateway_url,
        route_name=route_name
    ),
    json={
        "paths": [route_url],
        "strip_path": strip_path,
        "service": {"id": service_id},
        "preserve_host": True
    })
response_routes.json()
