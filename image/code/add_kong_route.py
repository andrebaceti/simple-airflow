"""Add Kong routes for Airflow on cluster."""
import os
import requests

#########################
# Getting ENV variables #
KONG_API_URL = os.getenv("KONG_API_URL")
SERVICE_URL = os.getenv("SERVICE_URL")

# Check if API_GATEWAY_URL is configured
if KONG_API_URL is not None:
    if SERVICE_URL is None:
        raise Exception("!! SERVICE_URL is not set !!")

    # Creating requests urls
    service_url = "{api_gateway_url}/services/{service_name}/".format(
        api_gateway_url=KONG_API_URL, service_name="airflow")
    routes_url = "{api_gateway_url}/routes/{route_name}/".format(
        api_gateway_url=KONG_API_URL, route_name="airflow--route")

    # Creating service
    payload = {
        'name': "airflow", 'url': SERVICE_URL}
    response_service = requests.put(service_url, json=payload)
    response_service.raise_for_status()
    response_service = response_service.json()

    # Creating route
    service_id = response_service["id"]
    route_url = "/airflow"
    route_name = "airflow--route"
    strip_path = False
    response_routes = requests.put(
        routes_url, json={
            "paths": [route_url],
            "strip_path": strip_path,
            "service": {"id": service_id},
            "preserve_host": True})
    response_routes.raise_for_status()
    response_routes = response_routes.json()
    print("# Kong routes and services configured for airflow:")
    print("- service url:", SERVICE_URL)
    print("- route path: /airflow")
else:
    print("# KONG_API_URL not set")
