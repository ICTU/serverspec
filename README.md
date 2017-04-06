# Serverspec

Find Dockerfile at 

Run as:

```
docker run -it \
  --net="host" \
  --volume="${PWD}/serverspec:/serverspec:ro" \
  --volume="/home/username/.ssh:/root/.ssh:ro" \
  --add-host="coreos-host:ip" \
  serverspec:1 rake spec
```
