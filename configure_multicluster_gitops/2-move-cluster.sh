oc label managedcluster ocp4stage "cluster.open-cluster-management.io/clusterset=all-clusters" --overwrite -n open-cluster-management
oc label managedcluster local-cluster "cluster.open-cluster-management.io/clusterset=all-clusters" --overwrite -n open-cluster-management
oc label managedcluster ocp4dev "cluster.open-cluster-management.io/clusterset=all-clusters" --overwrite -n open-cluster-management

