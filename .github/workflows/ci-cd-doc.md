## 🔐 Steps to Add GitHub Actions Secrets

To enable GitHub Actions to build, test, and deploy your app securely, you need to add several secrets to your GitHub repository.

### ✅ How to Add Secrets

1. Go to your **forked repository** on GitHub.
2. Navigate to **Settings** → **Secrets and variables** → **Actions**.
3. Click **New repository secret**.
4. Add the following secrets as listed below.

---

### 📋 Required Secrets

| Secret Name            | Description                                                                 | Required |
|------------------------|-----------------------------------------------------------------------------|----------|
| `AKS_CLUSTER_NAME`     | Name of your Azure Kubernetes Service (AKS) cluster                         | ✅       |
| `AKS_RESOURCE_GROUP`   | Resource group where your AKS cluster is deployed                           | ✅       |
| `AZURE_CREDENTIALS`    | JSON string with Azure Service Principal credentials for deployment         | ✅       |
| `DOCKERHUB_USERNAME`   | Your Docker Hub username                                                    | ✅       |
| `DOCKERHUB_TOKEN`      | Docker Hub access token or password                                         | ✅       |
| `NEXT_PUBLIC_API_URL`  | Public API base URL for the backend                                         | ✅       |

---

### 📝 Example Format for `AZURE_CREDENTIALS`

```json
{
  "clientId": "<your-client-id>",
  "clientSecret": "<your-client-secret>",
  "subscriptionId": "<your-subscription-id>",
  "tenantId": "<your-tenant-id>",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

## Dynamic Image Tagging

Tag docker images dynamically so that each build is uniquely tagged based on either:
1. the Git tag name (if you're pushing a tag), or
2. the Git commit SHA (if you're pushing to a branch).


If you push a tag (e.g., v1.0.0), images will be pushed as:</br>
```
yourusername/expensy-frontend:v1.0.0
yourusername/expensy-backend:v1.0.0
```

If you push a commit to a branch, it will use the commit SHA:</br>
```
yourusername/expensy-frontend:9e403af...
yourusername/expensy-backend:9e403af...
```

