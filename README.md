**how to install nginx ingress controller using helm**

To install the NGINX Ingress Controller using Helm, follow these steps:

✅ Prerequisites
Helm installed (helm version)
Kubernetes cluster running (e.g., via Kops)
kubectl configured to access your cluster

🧭 Step-by-Step Installation
1. Add the NGINX Ingress Helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

2. Install the Ingress Controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace

This will:
Create a namespace ingress-nginx
Deploy the NGINX Ingress Controller with default settings

3. Verify the Installation
kubectl get all -n ingress-nginx

Look for a LoadBalancer service named ingress-nginx-controller. The EXTERNAL-IP or HOSTNAME is what you'll use in your Ingress host field.

**how to install nginx ingress controller default method:**
1. Ingress Controller
install an Ingress controller like NGINX:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/aws/deploy.yaml

2.Then confirm it’s running:
kubectl get pods -n ingress-nginx

3. Argo CD Setup
You can install Argo CD in your Kops-managed cluster the same way:

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
