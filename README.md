# KMUTT CPE393 Lab docker
CPE393 Quantum Computing lab docker
Image: `topty/cpe393qlab`

## Docker Compose
We made a docker compose file for ease of use and you don't need to build a docker image

### Requirement
- Docker Engine 1.13.0+ 

### Usage
#### Start 
```bash
docker-compose up -d
```
#### Access to container
```bash
docker exec -it qlab bash
```

## Docker Image
```bash
docker pull topty/cpe393qlab
```