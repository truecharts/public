from contextlib import contextmanager

from kubernetes import client, config

from .utils import KUBECONFIG_FILE


@contextmanager
def api_client():
    config.load_kube_config(config_file=KUBECONFIG_FILE)
    api_cl = client.api_client.ApiClient()
    try:
        yield client.CoreV1Api(api_cl)
    finally:
        api_cl.close()
