## 1. Docker-ayes: Litecoin app

- Dockerfile and entrypoint.sh: forked from https://github.com/uphold/docker-litecoin-core/tree/master/0.18

- added buster.list to fix security bugs

#### How to build docker image

Build docker image for kratest

```bash
$ docker build -t pkchuyen/kratest:0.18.1 -f docker/Dockerfile .
```
Push to docker registry

```bash
$ docker login
$ docker push pkchuyen/kratest:0.18.1
```

#### Test container image security with Anchore

```bash
$ cd anchore
$ docker-compose up -d
$ docker-compose exec api anchore-cli image add pkchuyen/kratest:0.18.1
$ docker-compose exec api anchore-cli image get pkchuyen/kratest:0.18.1
$ docker-compose exec api anchore-cli evaluate check pkchuyen/kratest:0.18.1
```

Security check output:

```bash
$ docker-compose exec api anchore-cli evaluate check pkchuyen/kratest:0.18.1
Image Digest: sha256:c8932c9efe4043629188f87597b667bab1fdb88edd115b5bdfa7cd47b15aeea4
Full Tag: docker.io/pkchuyen/kratest:0.18.1
Status: pass
Last Eval: 2021-06-19T00:11:16Z
Policy ID: 2c53a13c-1765-11e8-82ef-23527761d060
```

## 2. k8s FTW

Kubernetes StatefulSet to run kratest using persistent volume claims and resources limits

- statefulset.yaml: forked from https://github.com/airstand/litecoin/blob/master/statefulset.yaml

```bash
$ cd k8s
$ kubectl apply -f statefulset.yaml
```
## 3. Jenkinsfile

Jenkinsfile is in the root path

## 4. Script kiddies:

tasks: find all untagged docker image id by using grep and awk

```bash
$ docker images
REPOSITORY                                               TAG                 IMAGE ID            CREATED             SIZE
kratest                                                  0.18.1              e3955646fe54        56 minutes ago      168MB
pkchuyen/kratest                                         0.18.1              e3955646fe54        56 minutes ago      168MB
<none>                                                   <none>              801fa29d7ed8        2 hours ago         168MB
<none>                                                   <none>              33fea47273b5        3 hours ago         168MB
```

shell command:
```bash
$ docker images | grep none  | awk '{print $3}'
```

## 5. Script grown-ups

Use python script to find untagged docker image, The script is located at `scripts/find_untagged_docker_image.py`

## 6. Terraform:

Terraform module is located in `terraform/module`.<br />
Use this module to create kratest-ci iam user, kratest-ci-role, kratest-ci-policy, kratest-ci-group at `terraform/test`
