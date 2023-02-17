# import-cluster-on-rhacm
A simple playbook to automate the Kubernetes cluster import and detach on RHACM using Ansible Tower.

## Requirements 

- Python >= 2.7

- Ansible Version >= 2.9 

## Tower Red Hat Advanced Cluster Management API Credentials Type

The login information for Red Hat Advanced Cluster Management  must be saved in Tower using a custom credentials type defined as follows. 

*INPUT CONFIGURATION:*

```yaml
fields:
  - id: api_endpoint
    type: string
    label: API Endpoint
  - id: api_token
    type: string
    label: API Token
    secret: true
required:
  - api_endpoint
  - api_token
```


*INJECTOR CONFIGURATION:*

```yaml
extra_vars:
  rhacm_api: '{{ api_endpoint }}'
  rhacm_token: '{{ api_token }}'
```

## Tower configuration details

The Job Templates must use the RHACM credentials prepared using Red Hat Advanced Cluster Management API Credentials Type, the inventory must contain localhost with the following host vars: 
```yaml
---
ansible_connection: local
ansible_python_interpreter: /var/lib/awx/venv/ansible/bin/python
```

The following extra_vars are required for import-on-rhacm-tower.yaml: 

- cluster_type: the label configured on the imported cluster.
- managed_cluster_name
- managed_cluster_api
- managed_cluster_token 

The following extra_vars are required for detach-from-rhacm-tower.yaml:

- managed_cluster_name 
