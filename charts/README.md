## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

helm repo add wocoio https://woco-io.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
wocoio` to see the charts.

To install the k8s-iam-manager chart:

    helm install k8s-iam-manager wocoio/k8s-iam-manager

To uninstall the chart:

    helm delete k8s-iam-manager