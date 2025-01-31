#!/bin/bash

echo "## Verify Starting Script"

tekton_secret_namespace="${1:-openshift-pipelines}"
cosign_secret_name="${2:-signing-secrets}"
pipeline_namespace="${3:-pac-demo-pipelines}"
writable_space="${4:-/workdir}"
pipeline_label="${5:-pac-demo}"

printf "Getting Most Recent Pipeline Run for ${pipeline_label}\n"
pipelinerun=$(oc get pipelinerun -n ${pipeline_namespace} -l tekton.dev/pipeline=${pipeline_label} --sort-by=.metadata.creationTimestamp | tail -n 1| awk '{print $1}')
printf "Found Pipeline Run ${pipelinerun}\n\n"

printf "Will attempt to Verify Task Runs for Pipeline Run ${pipelinerun}\n"
for taskrun in $(oc get taskrun -n ${pipeline_namespace} -l tekton.dev/pipelineRun=${pipelinerun} -o name)
do
  printf "\n"
  printf "Start Verification of TaskRun ${taskrun} in PipelineRun ${pipelinerun}\n"
  TASKRUN_UID=$(oc get $taskrun -n ${pipeline_namespace} -o jsonpath='{.metadata.uid}')
  oc get $taskrun -n ${pipeline_namespace} -o jsonpath="{.metadata.annotations.chains\.tekton\.dev/signature-taskrun-$TASKRUN_UID}" > ${writable_space}/signature
  oc get $taskrun -n ${pipeline_namespace} -o jsonpath="{.metadata.annotations.chains\.tekton\.dev/payload-taskrun-$TASKRUN_UID}" | base64 -d > ${writable_space}/payload
  cosign verify-blob -d --key k8s://${tekton_secret_namespace}/${cosign_secret_name} --signature ${writable_space}/signature ${writable_space}/payload 
  if [ "$?" -eq 0 ]
  then
    printf "Verified TaskRun ${taskrun} in PipelineRun ${pipelinerun}\n"
    printf "\n"
  else
    printf "Could not verify TaskRun ${taskrun} in PipelineRun ${pipelinerun}"
    printf "\n"
  fi
done

