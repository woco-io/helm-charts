# k8s-iam-manager Helm Chart

This chart installs k8s-iam-manager deployment.<br>
<br>
This Helm chart simplifies the process of binding Google Service Accounts (GSA) to Kubernetes Service Accounts (KSA) in a Kubernetes environment, particularly when using Google Kubernetes Engine (GKE). The service automatically handles the necessary IAM binding between GSAs and KSAs.

## Features

- Automatically binds GSAs to KSAs using the specified GKE annotation.
- Configurable to work in a specific Kubernetes namespace.
- Supports Google Cloud Platform (GCP) and integrates with IAM roles.
- Configurable resource limits, liveness, readiness probes, and more.

## Chart Details

- **Chart Name**: `k8s-iam-manager`
- **Version**: `1.0.0`
- **Application Version**: `1.0.0`
- **Home**: [woco-io](https://github.com/woco-io)
- **Sources**: [GitHub Repository](https://github.com/woco-io/k8s-iam-manager)
- **Maintainer**: Yehoraz Levi ([email](mailto:yehoraz3@gmail.com), [GitHub](https://github.com/Yehoraz))

## Installation

### Prerequisites

- A Kubernetes cluster.
- Helm 3.x installed.

### Setup Repo Info

```console
helm repo add woco-io https://woco-io.github.io/helm-charts/
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._


### Install the Chart

To install the `k8s-iam-manager` chart, use the following Helm command:

```bash
kubectl create namespace <your-namespace>
helm install my-k8s-iam-manager woco-io/k8s-iam-manager --version <chart-chosen-version> --namespace <your-namespace>
```

### Uninstalling the Chart

To uninstall/delete the `my-k8s-iam-manager` deployment:

```console
helm delete my-k8s-iam-manager --namespace <your-namespace>
```

### Configuration

The `k8s-iam-manager` chart can be customized by editing the `values.yaml` file or by passing custom values with the `--set` flag during installation.

```bash
helm install my-k8s-iam-manager woco-io/k8s-iam-manager --version <chart-chosen-version> --namespace <your-namespace> --set app.name=my-app,app.image.tag=latest
```

For more details on configuration options, refer to the section below.

## Values Configuration


### Available Values

| Key                                 | Description                                                                                                      | Default Value           |
|-------------------------------------|------------------------------------------------------------------------------------------------------------------|-------------------------|
| `isAutomaticPermissions`            | Whether to automatically create service permissions (RBAC) and Kubernetes Service Account (KSA)                  | `true`                  |
| `app.name`                          | Name of the application.                                                                                         | `k8s-iam-manager`       |
| `app.image.name`                    | Docker image name for the service.                                                                                | `woco.io/k8s-iam-manager`|
| `app.image.tag`                     | Docker image tag.                                                                                                 | `1.0`                   |
| `app.image.pullPolicy`              | Image pull policy.                                                                                                | `IfNotPresent`          |
| `app.port`                          | Port for the service.                                                                                             | `5000`                  |
| `app.env`                           | Environment variables for the service. See `env` section for more details.                                        | `{}`                    |
| `labels`                            | Labels for the resources created by this chart.                                                                   | `{"app": "k8s-iam-manager"}` |
| `annotations`                       | Annotations for the resources created by this chart.                                                              | `{"app": "k8s-iam-manager"}` |
| `strategy`                          | Deployment strategy. Configure rolling updates and other settings.                                                | `RollingUpdate`         |
| `strategy.maxSurge`                 | Maximum number of pods to be created above the desired number during a rolling update.                           | `25%`                   |
| `strategy.maxUnavailable`           | Maximum number of pods that can be unavailable during a rolling update.                                           | `25%`                   |
| `replicas`                          | Number of replicas for the service.                                                                                | `1`                     |
| `nodeSelector`                      | Node selector for pod scheduling.                                                                                 | `{}`                    |
| `affinity`                          | Affinity rules for pod scheduling.                                                                                | `{}`                    |
| `tolerations`                       | Tolerations for pod scheduling.                                                                                   | `{}`                    |
| `imagePullSecrets`                  | Secrets to use for pulling images from private registries.                                                        | `[]`                    |
| `liveness`                          | Configurations for liveness probes. See `liveness` section for more details.                                        | `{}`                    |
| `readiness`                         | Configurations for readiness probes. See `readiness` section for more details.                                     | `{}`                    |
| `resources`                         | Resource requests and limits for the service. See `resources` section for more details.                           | `{}`                    |
| `serviceAccountName`                | Name of the service account to be used by the pod.                                                                | `""`                    |
| `gcpServiceAccount`                 | Google Cloud Service Account to be used for API calls against GCP.                                                 | Required                |


### Custom Values

You can override the default values in the `values.yaml` file during installation by passing custom values via the `--set` flag or by providing a custom values file.

For example:

```bash
helm install k8s-iam-manager ./path-to-chart --set app.image.tag="latest",app.port=8080
```

## Notes

- The service requires the `APP_GCP_PROJECT_ID` and `APP_GCP_PROJECT_NUMBER` to be set for GCP integration.
- Ensure your Kubernetes cluster is running on GKE to take full advantage of the GSA <-> KSA binding features.
- You can customize resource requests and limits in the `values.yaml` file to suit your deployment needs.


## Values Schema

This chart uses a values schema to enforce valid configuration. The schema can be found in the `values.schema.json` file, which includes detailed descriptions of all configurable properties.

You can validate your values by running:

```bash
helm install --dry-run --debug k8s-iam-manager ./path-to-chart
```

## Conclusion

The `k8s-iam-manager` Helm chart simplifies the management of Google Kubernetes Engine (GKE) workloads by automating the process of binding Google Service Accounts to Kubernetes Service Accounts. This chart provides a customizable deployment solution that integrates easily with GCP IAM and Kubernetes RBAC.
