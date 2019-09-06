## Restore the production pd-ssd from a snapshot

1. Create a new pd-ssd disk from the source snapshot

Specify size (10GB), name (example-disk-name), zone (northamerica-northeast1-b), type (pd-ssd), source snapshot (first-prod-snapshot), snapshot schedule (backup-utc)

```bash
gcloud compute disks create example-disk-name --zone=northamerica-northeast1-b --source-snapshot=first-prod-snapshot --size=10GB --type=pd-ssd --resource-policies=backup-utc
```

2. Scale down the server deployment

```bash
kubectl scale deployment minecraft-server --replicas=0
```

3. Update the yaml to use the newly created disk and apply it

Update the PersistentVolume in `k8s/volume.yml` with the name of the new disk under the `PersistentVolume.metadata.name` spec

```yaml
kind: PersistentVolume
metadata:
  name: example-disk-name
```

```bash
kubectl apply -f k8s
```

4. Scale the deployment back up

```bash
kubectl scale deployment minecraft-server --replicas=1
```

5. Cleanup

Use the GUI to delete unused disks

kubectl delete any unused replicasets
