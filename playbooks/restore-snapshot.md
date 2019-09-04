## Restore the production server's disk to a snapshot

1. Create a new pd-ssd disk from the source snapshot

Specify size, name, zone, type, source snapshot, snapshot schedule (--resource-policies)

```bash
gcloud compute disks create example-disk-name --zone=northamerica-northeast1-b --source-snapshot=first-prod-snapshot --size=10GB --type=pd-ssd --resource-policies=backup-utc
```

Click [CREATE DISK](https://console.cloud.google.com/compute/disks/)

  * Pick a name, this will go in the yaml in a next step
  * region mtl in zone b
  * with snapshot schedule backup-utc
  * size 10Gb

2. Scale down the server deployment

```bash
kubectl scale deployment spigot-server --replicas=0
```

3. Delete the old pv & pvc

```bash
kubectl get pv
kubectl delete OLD_PV_NAME

kubectl get pvc
kubectl delete OLD_PVC_NAME
```

4. Update the yaml to use the newly created disk in the PersistentVolume

Update `k8s/static/volume.yml` with the name of the new disk under the `PersistentVolume.metadata.name` spec

```yaml
kind: PersistentVolume
metadata:
  name: example-disk-name
```

5. Apply new pv & pvc

```bash
kubectl apply -f k8s/static
```

6. Scale the deployment back up

```bash
kubectl scale deployment spigot-server --replicas=1
```

7. Cleanup

Use the GUI to delete unused disks
Kubectl delete any unused replicasets
