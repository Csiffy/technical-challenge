# Paint batch optimizer service

## Purpose

This service provides solutions for the following problem.

Our users own paint factories. There are N different colors they can mix, and each color can be prepared "matte" or "glossy". So, you can make 2N different types of paint.

Each of their customers has a set of paint types they like, and customers will be satisfied if you have at least one of those types prepared. At most one of the types a customer likes will be a "matte".

Our user wants to make N batches of paint, so that:

There is exactly one batch for each color of paint, and it is either matte or glossy. For each customer, user makes at least one paint that they like. The minimum possible number of batches are matte (since matte is more expensive to make). This service finds whether it is possible to satisfy all customers given these constraints, and if it is, what paint types you should make. If it is possible to satisfy all your customers, there will be only one answer which minimizes the number of matte batches.

Input

Integer N, the number of paint colors,  integer M, the number of customers. A list of M lists, one for each customer, each containing: An integer T >= 1, the number of paint types the customer likes, followed by T pairs of integers "X Y", one for each type the customer likes, where X is the paint color between 1 and N inclusive, and Y is either 0 to indicate glossy, or 1 to indicated matte. Note that: No pair will occur more than once for a single customer. Each customer will have at least one color that they like (T >= 1). Each customer will like at most one matte color. (At most one pair for each customer has Y = 1). 

Output

The string "IMPOSSIBLE", if the customers' preferences cannot be satisfied; OR N space-separated integers, one for each color from 1 to N, which are 0 if the corresponding paint should be prepared glossy, and 1 if it should be matte.


## Install

Firstly you have to build the docker image locally and push to a repository (It can be a local or a cloud based repository)

```bash
make build
```

Before to push the image, please change the "REPOSITORY" variable in the Makefile
("CONTAINERNAME" and "VERSION" are optional)

```bash
make push_to_repo
```

We will using the image in Kubernetes environment, so the Kubernetes must to reach the repository

If you would like to test locally, this is an easy way to install a repository and push the image into it

```bash
docker pull registry:2
docker run -d --name registry -p 5000:5000 registry:2
docker tag aylien/techtest-py:latest localhost:5000/aylien/techtest-py:latest
docker push localhost:5000/aylien/techtest-py:latest
```

If you use cloud provider for the kubernetes cluster, please ensure the authentication and the kubeconfig setup

Create a separate namespace to the application

```bash
kubectl create namespace aylien
```

Deploy the application into the Kubernetes cluster

```bash
kubectl apply -f kubernetes/aylien-techc-deploy.yaml
```

We need to create a service to reach the deployed container

```bash
kubectl apply -f kubernetes/aylien-techc-service.yaml
```

If you would like to scale the deployed number of containers, then here is and example command for it

```bash
kubectl scale --replicas=1 deployment/tech-challenge-deploy
```

This was the easiest and simple way to deploy the application, but instead it you should deploy the application with a configuration manager, like ansible or you can use terraform or any CI/CD tools, like Gitlab-CI, Jenkins, etc. Maybe the best way if you create the resources with terraform and controlling it with a CI tool.


## Usage

In the `app` directory you will see a small Python web service (`app.py`), a dependency list (`requirements.txt`) and a `Makefile`. The `Makefile` contains 2 targets: `build` that just installs the requirements into the current Python environment, and `run` which runs an example instance of the application.

The application has a primary endpoint at `/v1/`. When you make calls to this endpoint, you can send a JSON string as the argument "input". The JSON string contains three keys: colors, costumers and demands.

Examples:

http://0.0.0.0:8080/v1/?input={%22colors%22:1,%22customers%22:2,%22demands%22:[[1,1,1],[1,1,0]]}
IMPOSSIBLE

http://0.0.0.0:8080/v1/?input={%22colors%22:5,%22customers%22:3,%22demands%22:[[1,1,1],[2,1,0,2,0],[1,5,0]]}
1 0 0 0 0

## Limitations

None of our users produce more than 2000 different colors, or have more than 2000 customers. (1 <= N <= 2000 1 <= M <= 2000)
The sum of all the T values for the customers in a request will not exceed 3000.
