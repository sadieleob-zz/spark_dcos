cd /work/mycluster/spark2.9.0-2.4.3
dcos security org service-accounts keypair spark-private-key.pem spark-public-key.pem
dcos security org service-accounts create -p spark-public-key.pem -d "Spark service account" spark-principal
dcos security org service-accounts show spark-principal
dcos security secrets create-sa-secret --strict spark-private-key.pem spark-principal spark/spark-secret
dcos security secrets list /


## Permissions
dcos security org users grant spark-principal dcos:mesos:master:task:user:nobody create --description "Allows the Linux user to execute tasks"

dcos security org users grant spark-principal dcos:mesos:master:framework:role:* create --description "Allows a framework to register with the Mesos master using the Mesos default role"

dcos security org users grant spark-principal dcos:mesos:master:task:app_id:/spark create --description "Allows reading of the task state"

dcos security org users grant dcos_marathon dcos:mesos:master:task:user:nobody create --description "Allow Marathon to launch containers as nobody"

## Spark options
cat > spark-strict-options.json <<EOF
{
"service": {
        "service_account": "spark-principal",
        "user": "nobody",
        "service_account_secret": "spark/spark-secret"
        }
}
EOF

dcos package install spark --options=spark-strict-options.json --yes



