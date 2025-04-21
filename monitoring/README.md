# 📈 Steps to deploy Prometheus, Grafana,node-exporter,alert manager etc

## ✅ Prerequisites
1. Verify Helm Installation
```helm version```

2. Verfiy connection to your AKS Cluster
```kubectl config current-context```

## 🚀 Deployment Steps

### Step A: Add Helm Repositories
1. Add the Prometheus Community Repo

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

2. (Optional) Add the Stable Charts Repository

```
helm repo add stable https://charts.helm.sh/stable
helm repo update

```

### Step B: Create a Namespace for Monitoring
To keep the monitoring components isolated, create a dedicated namespace (e.g., monitoring):
```
kubectl create namespace monitoring
```
### Step C: Install the kube-prometheus-stack
1. Deploy Prometheus and Grafana using Helm:

```
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring

```
This package deploys Prometheus, Grafana, and additional Kubernetes monitoring components.

2. Verify Deployment:

```
kubectl get pods -n monitoring
kubectl get svc -n monitoring

```

### Step D: Expose Prometheus and Grafana Outside the Cluster
By default, the services are deployed as ClusterIP, accessible only inside the cluster. Update them to LoadBalancer so they are accessible from browser.

1. Edit the Prometheus Service:

```
kubectl get svc -n monitoring
kubectl edit svc kube-prometheus-stack-prometheus -n monitoring
```
In the editor, change the type: field from ClusterIP to LoadBalancer, then save and exit.

2. Edit the Grafana Service
```
kubectl edit svc kube-prometheus-stack-grafana -n monitoring
```
Similarly for Grafan, change the type: field from ClusterIP to LoadBalancer. Save and exit.

---
# Metrics in Grafana Dashboards

## Backend Metrics
Grafana backend dashboard tailored to visualize the following Prometheus metrics:
1. ```mongo_connection_status``` (Type: gauge)
2. ```expenses_total``` (Type: counter)
(Total number of expenses recorded in the DB)
3. ```http_requests_overall_total``` (Type: counter)
(Cumulative number of HTTP requests since the app started)
4. ```http_requests_total{method=..., route=..., statusCode=...}``` </br>
(HTTP Requests Breakdown) </br>
    Usage: 
    -  Group by statusCode to track errors (rate(http_requests_total{statusCode=~"5.."}[1m]))
    -  Track specific routes or high error endpoints.
5. ```process_cpu_seconds_total```
(these show how much CPU time (in seconds) the app has used in total (use rate() in Prometheus to get % CPU usage over time).)
6. ```process_resident_memory_bytes```
(actual RAM used )
7. ```nodejs_heap_size_used_bytes``` vs ```nodejs_heap_size_total_bytes```: how much heap is in use vs allocated.
Useful for tracking memory leaks or usage over time.

## Infrastructure Metrics
The nodes dashboard provides an insightful visualization of key system metrics collected via Prometheus. It focuses primarily on CPU, memory, and load metrics for monitoring system health and performance in real-time.
1. ```(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100```
   (shows the percentage of memory used on the system) 
2. ```promhttp_metric_handler_requests_in_flight{job="node-exporter"}```
   (Number of Scrapes: tracks the number of HTTP requests currently being handled by the Prometheus HTTP handler)
3. ```process_virtual_memory_bytes{job="node-exporter"}```
   (represents total virtual memory used by each process)
4. ```node_load1{instance=~".*"}``` (CPU load average (1m))
5. ```100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)```
   (shows the percentage of CPU usage across all cores)
