# WOCO-IO Helm Charts

Welcome to the **WOCO-IO Helm Charts** repository! 🎉

This repository hosts Helm charts for deploying WOCO-IO services to Kubernetes. These charts are designed to simplify deployment, configuration, and management of our services for developers and DevOps teams.

## Repository Structure

- **charts/**: Contains individual Helm charts for our services.
- **docs/**: Contains documentation for our services Helm charts.

## Prerequisites

To use these charts, you need the following:
- [Helm](https://helm.sh/) (v3 or later)
- Access to a Kubernetes cluster
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Usage

1. Add the WOCO-IO Helm repository:
   ```bash
   helm repo add woco-io https://woco-io.github.io/helm-charts/
   ```

2. Update your local Helm repository:
   ```bash
   helm repo update
   ```

3. Install a chart:
   ```bash
   helm install <release-name> woco-io/<chart-name> --values <values-file>.yaml
   ```

4. Upgrade a release:
   ```bash
   helm upgrade <release-name> woco-io/<chart-name> --values <values-file>.yaml
   ```

5. Uninstall a release:
   ```bash
   helm uninstall <release-name>
   ```

## Contributing

We welcome contributions to improve our Helm charts!

### Steps to Contribute

1. Fork this repository.
2. Create a branch for your changes: `git checkout -b my-feature-branch`
3. Make your updates and ensure charts pass linting using:
   ```bash
   helm lint charts/<chart-name>
   ```
4. Commit your changes: `git commit -m "Describe your changes"`
5. Push to your branch: `git push origin my-feature-branch`
6. Open a pull request against the `main` branch.

### Guidelines

- Follow the [Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/).
- Test your changes thoroughly.
- Update documentation and examples if applicable.

## Support

For any issues, feel free to open a GitHub issue or contact the WOCO-IO team.

---

Thank you for using our Helm charts! 🚀
