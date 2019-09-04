## Restore the production pd-ssd from a snapshot

1. Create a new pd-ssd disk from the source snapshot

Specify size (10GB), name (example-disk-name), zone (northamerica-northeast1-b), type (pd-ssd), source snapshot (first-prod-snapshot), snapshot schedule (backup-utc)

```bash
gcloud compute disks create example-disk-name --zone=northamerica-northeast1-b --source-snapshot=first-prod-snapshot --size=10GB --type=pd-ssd --resource-policies=backup-utc
```

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

kubectl delete any unused replicasets
