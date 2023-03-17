# Install PostgreSQL
kubectl create ns db
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install db -n db --set global.postgresql.auth.username=flask-sample-app --set global.postgresql.auth.password=password  --set image.tag=14.1.0-debian-10-r88 --set global.postgresql.auth.database=flask-sample-app  bitnami/postgresql

helm uninstall db -n db



kubectl create secret docker-registry regcred --docker-server=registry.gitlab.com --docker-username=ferios08 --docker-password="glpat-aaa"


k create secret generic db-creds  --from-literal=POSTGRES_USERNAME=flask-sample-app   --from-literal=POSTGRES_PASSWORD=password  --from-literal=POSTGRES_HOST=db-postgresql.db.svc.cluster.local    --from-literal=POSTGRES_PORT=5432    --from-literal=POSTGRES_DATABASE=flask-sample-app --dry-run -o yaml