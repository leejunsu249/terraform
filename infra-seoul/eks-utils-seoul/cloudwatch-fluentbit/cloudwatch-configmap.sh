FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'

export no=$(kubectl get configmap fluent-bit-cluster-info -n amazon-cloudwatch  | grep fluent-bit-cluster-info | wc -l)

if [ $no -eq 0 ]; then 
    kubectl create configmap fluent-bit-cluster-info \
    --from-literal=cluster.name=${EKS_CLUSTER} \
    --from-literal=http.server=${FluentBitHttpServer} \
    --from-literal=http.port=${FluentBitHttpPort} \
    --from-literal=read.head=${FluentBitReadFromHead} \
    --from-literal=read.tail=${FluentBitReadFromTail} \
    --from-literal=logs.region=${AWS_REGION} -n amazon-cloudwatch
fi