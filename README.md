# Observatory deployment

This repository contains tools to deploy all components of Observatory.

## Deployment

Components are deployed with Helmfile. With Helmfile all components are deployed to a Kubernetes cluster.

The following diagram shows an overview of software components as well as a number of versioned artifacts.

TODO

### Helmfile

#### Establish Environment

* get secrets from bitwarden:
  * get ssh public and private key
  * get kubeconfig
  * use env-template.sh and create env.sh and add it as source in your console
* use port forwarding to get connection to cluster, e.g.: `ssh -L 16443:localhost:6443 observatory`
* check that port forwarding is running e.g. with `kubectl get all --all-namespaces`

#### Execute

With Helmfile you need a running Kubernetes cluster and your KUBECONFIG variable needs to point to an according config. If this is the case, the following command will install all components to namespace _aic_.

```bash
    cd smartparking-hub
    helmfile diff -f smartparking-data-hub.yaml -e wob-staging # check planned changes
    helmfile apply -f smartparking-data-hub.yaml -e wob-staging
```

#### Connection to Database

* start pgadmin e.g. via docker compose script in your deployment project and add db connection:
  * get postgres credentials from kubernetes secrets
  * get your IP address, e.g. `hostname -I | awk '{print $3}'`
  * use port forwarding with your ip (e.g. via k9s) to be able to reach postgres port

## Component Breakdown

The components of Starwit's implementation of AI cockpit can be found in the following repositories:

| Component       | Repository / URI                                       |             Description            |
| ----------------| -------------------------------------------------------| ---------------------------------- |
| Observatory Lens|<https://github.com/starwit/observatory-lens>           | Configuration of observation areas |
| Observatory     |<https://github.com/starwit/observatory>                | Jobs for data analysis             |

For more details about AI Cockpit visit project page: <https://www.kicockpit.eu/>
