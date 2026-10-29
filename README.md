# Spring Boot Thymeleaf Sample

[![Java CI with Maven](https://github.com/hendisantika/customer-sample/actions/workflows/maven.yml/badge.svg)](https://github.com/hendisantika/customer-sample/actions/workflows/maven.yml)
![Java](https://img.shields.io/badge/Java-25-orange?logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.1-6DB33F?logo=springboot)

This is a sample project demonstrating the use of **Spring Boot** with **Thymeleaf** for building a simple web
application. The application manages a list of customers, allowing users to perform CRUD (Create, Read, Update, Delete)
operations.

## Features

- **Spring Boot** for backend development.
- **Thymeleaf** for server-side rendering of HTML templates.
- **Tailwind CSS** for responsive and modern UI design.
- **H2** in-memory database for storing customer data.
- **Docker Compose** for containerized application setup.
- **Kubernetes** and **Skaffold** for cloud-native deployment.

## Prerequisites

- JDK 25 (e.g. Temurin or Amazon Corretto 25)
- Maven 3.9+ (or use the bundled Maven Wrapper `./mvnw`)
- Docker (optional, for containerized deployment)
- Kubernetes cluster (optional, for Kubernetes deployment)
- Skaffold (optional, for Kubernetes development workflow)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/hendisantika/customer-sample.git
cd customer-sample
```

2. Database Setup
   The application uses H2 in-memory database by default, so no additional setup is required.
   The database configuration can be found in `src/main/resources/application.yml`.

3. Build and Run the Application

   **Option 1: Run with Maven**
    ```shell
    ./mvnw clean install
    ./mvnw spring-boot:run
    ```

   **Option 2: Run with Docker**
    ```shell
    ./mvnw clean package
    docker-compose up -d
    ```

   When running with Docker, the `customer-photos` directory is mounted as a volume to persist photos outside the
   container. This ensures that uploaded customer photos are accessible from the web application.

   **Option 3: Run with Kubernetes and Skaffold**
    ```shell
    ./mvnw clean package
    skaffold run
    ```

   For development with hot-reload:
    ```shell
    skaffold dev
    ```

   When running with Kubernetes, the application will be deployed to your Kubernetes cluster according to the manifests
   in the `k8s` directory.

   The application will be available at http://localhost:9003 (or through your Kubernetes cluster's ingress if
   configured).

   For detailed instructions on deploying to a Kubernetes cluster in a VPS environment,
   see [KUBERNETES_DEPLOYMENT.md](KUBERNETES_DEPLOYMENT.md).

   **Option 4: Continuous Deployment with GitHub Actions**

   This project includes a GitHub Actions workflow that builds, publishes, and (optionally) deploys the application.
   See [CI/CD](#cicd) below for details.

   For detailed instructions on setting up continuous deployment to Kubernetes with GitHub Actions,
   see [GITHUB_ACTIONS_K8S_DEPLOYMENT.md](GITHUB_ACTIONS_K8S_DEPLOYMENT.md).

### CI/CD

The [Java CI with Maven](.github/workflows/maven.yml) workflow runs on every push and pull request to `main`, and can
be triggered manually:

| Job                                | Runs when                                                            | What it does                                                                                                                    |
|------------------------------------|----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| **Build & test (JDK 25)**          | Every push / pull request                                            | `mvn verify` on Temurin JDK 25                                                                                                  |
| **Publish image**                  | Push to `main`                                                       | Builds a multi-arch (`amd64`/`arm64`) image with Jib on `amazoncorretto:25`, pushes `hendisantika/customer` to Docker Hub, and submits the dependency graph |
| **Deploy image / Deploy to Kubernetes** | Push to `main` **and** repository variable `ENABLE_CLOUDRAYA_DEPLOY=true` | Pushes to the Cloud Raya registry and deploys via SSH and to Kubernetes                                                         |

The Cloud Raya push and deployments are opt-in: set the repository variable `ENABLE_CLOUDRAYA_DEPLOY` to `true` once
valid `CLOUDRAYA_*`, `SSH_PRIVATE_KEY` and `KUBE_CONFIG` secrets are configured.

Required secrets for publishing: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`.

### Dependency Updates

[Dependabot](.github/dependabot.yml) keeps dependencies current:

- **Maven** – daily; Spring updates are grouped together and other minor/patch bumps are bundled into one PR.
- **GitHub Actions** – daily, grouped into a single PR.
- **Docker** – weekly for the `amazoncorretto` base image, staying on the Java 25 line (major bumps are ignored).

Dependabot PRs use conventional commit prefixes (`build(deps)`, `ci(deps)`, `build(docker)`).

### Application Endpoints

1. Home Page: `/` - Displays the list of customers.
2. Add Customer: `/create` - Form to add a new customer.
3. View Customer: `/customer/{id}` - View details of a specific customer.
4. Edit Customer: `/customer/{id}/edit` - Edit details of a specific customer.
5. Delete Customer: `/customer/{id}/delete` - Delete a specific customer.

### Technologies Used

1. Java 25
2. Spring Boot 4.1
3. Thymeleaf
4. Tailwind CSS
5. H2 Database
6. Docker Compose
7. Kubernetes
8. Skaffold
9. Jib
10. GitHub Actions & Dependabot

### Project Structure

`src/main/java` - Contains the Java source code.
`src/main/resources/templates` - Thymeleaf templates for the UI.
`src/main/resources/application.yml` - Configuration file for the application.
`Dockerfile` - Docker configuration for building the application image.
`docker-compose.yml` - Docker Compose configuration for running the application with volume mounts.
`k8s/deployment.yaml` - Kubernetes Deployment manifest.
`k8s/service.yaml` - Kubernetes Service manifest.
`skaffold.yaml` - Skaffold configuration for Kubernetes development workflow.
`.github/workflows/maven.yml` - CI/CD workflow (build, publish, deploy).
`.github/dependabot.yml` - Dependabot configuration.

### Screenshots

#### Home Page
Displays the list of customers with options to view, edit, or delete.

![Home Page](img/list.png "list page")

#### Add Customer
Form to add a new customer.

![Add Customer](img/home.png "Add Customer")

![Add Customer](img/add.png "Add Customer")

#### View Customer
Displays detailed information about a specific customer.

![View Customer](img/edit.png "View Customer")

### License
This project is licensed under the MIT License. See the LICENSE file for details.

### Author
Developed by Hendi Santika.
https://s.id/hendisantika
