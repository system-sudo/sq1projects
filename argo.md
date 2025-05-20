Updated Helm Upgrade Command for Subpath /argocd

helm upgrade argocd argo/argo-cd -n argocd \
  --set server.ingress.enabled=true \
  --set server.ingress.ingressClassName=nginx \
  --set server.ingress.hosts[0]=a22a57093d9394c089054cc04f030daf-2055213054.us-east-1.elb.amazonaws.com \
  --set server.ingress.paths[0]=/argocd \
  --set server.ingress.pathType=Prefix \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/rewrite-target"="/\$2" \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/use-regex"="true" \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/ssl-redirect"="true" \
  --set server.ingress.annotations."nginx\.ingress\.kubernetes\.io/backend-protocol"="HTTPS" \
  --set configs.params."server\.rootpath"="/argocd" \
  --set configs.params."server\.insecure"=true
