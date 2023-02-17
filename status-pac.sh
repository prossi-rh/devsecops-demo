printf "\n## Nexus Server - Username/Password: admin/admin123 ##\n"
NEXUS=$(oc get route -n pac-demo-pipelines nexus -o jsonpath='{.spec.host}')
printf "https://$NEXUS"
printf "\n"

printf "\n## Sonarqube Server - Username/Password: admin/admin ##\n"
SONARQUBE=$(oc get route -n pac-demo-pipelines sonarqube -o jsonpath='{.spec.host}')
printf "https://$SONARQUBE"
printf "\n"

printf "\n## Reports Server - Username/Password: reports/reports ##\n"
REPORTS=$(oc get route -n pac-demo-pipelines reports-repo -o jsonpath='{.spec.host}')
printf "http://$REPORTS"
printf "\n"

printf "\n## ACS/Stackrox Server - Username/Password: admin/stackrox ##\n"
ACS=$(oc get route -n stackrox central -o jsonpath='{.spec.host}')
printf "https://$ACS"
printf "\n"

printf "\n## ArgoCD Server - Username/Password: admin/[DEX] ##\n"
ARGO=$(oc get route -n openshift-gitops openshift-gitops-server -o jsonpath='{.spec.host}')
printf "https://$ARGO"
printf "\n"
