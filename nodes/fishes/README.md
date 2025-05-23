This folder contains configuration files for all my servers.

The architecture of my cluster (aquarium) is following these rules:
1) if service is bound to specific hardware, install it as package in physical node.
2) if service is hard to manage or can't be run in k8s, create dedicated vm for it.
3) anything else should run in k8s.

So architecture of single server node consists of:
------------------------------------------------
|          Kubernetes + Ceph (client)          |
|----------------------------------------------|
|  k0s VM #1 | k0s VM #2 |                     |
|------------------------| Ceph Storage System |
|     KVM Hypervisor     |              (node) |
|----------------------------------------------|
|               NixOS on Linux                 |
------------------------------------------------