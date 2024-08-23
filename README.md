# Authentication API

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-black?style=for-the-badge&logo=JSON%20web%20tokens)
![IntelliJ IDEA](https://img.shields.io/badge/IntelliJIDEA-000000.svg?style=for-the-badge&logo=intellij-idea&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)

This project is an API built using **Java, Java Spring, MySQL as the database, and Spring Security and JWT for authentication control.**

The API demonstrate how to configure Authentication and Authorization in Spring application using Spring Security.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Authentication](#authentication)
- [Database](#database)
- [Contributing](#contributing)
- [Screenshots](#screenshots)

## Installation

1. Clone the repository:

```bash
git clone https://github.com/kenzor1979/auth-api.git
```

2. Install dependencies with Maven

3. Install [MySQL](https://www.mysql.com/)

## Usage

1. Start the application with Maven
2. The API will be accessible at http://localhost:8080

## API Endpoints

The API provides the following endpoints:

```markdown
GET /product - Retrieve a list of all products. (all authenticated users)

POST /product - Register a new product (ADMIN access required).

POST /auth/login - Login into the App

POST /auth/register - Register a new user into the App
```

## Authentication

The API uses Spring Security for authentication control. The following roles are available:

```
USER -> Standard user role for logged-in users.
ADMIN -> Admin role for managing partners (registering new partners).
```
To access protected endpoints as an ADMIN user, provide the appropriate authentication credentials in the request header.

Authorization type is Bearer Token.

## Database

The project utilizes [MySQL](https://www.mysql.com/) as the database. 

It is necessary to create a schema named "auth" or change the schema name in the "application.properties" file.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request to the repository.

When contributing to this project, please follow the existing code style, [commit conventions](https://www.conventionalcommits.org/en/v1.0.0/), and submit your changes in a separate branch.

## Screenshots

Register as Admin Role
![Register as Admin](https://github.com/kenzor1979/auth-api/blob/main/img/registerAsAdmin.gif?raw=true&sanitize=true)

Register as User Role
![Register as User](https://github.com/kenzor1979/auth-api/blob/main/img/registerAsUserRole.gif?raw=true&sanitize=true)

Login
![Login](https://github.com/kenzor1979/auth-api/blob/main/img/login.gif?raw=true&sanitize=true)

Authorization
![Authorization](https://github.com/kenzor1979/auth-api/blob/main/img/authorization.gif?raw=true&sanitize=true)

Post
![post](https://github.com/kenzor1979/auth-api/blob/main/img/post.gif?raw=true&sanitize=true)

MySQL table products
![MySQL products](https://github.com/kenzor1979/auth-api/blob/main/img/MySQLproducts.png?raw=true&sanitize=true)

MySQL table users
![MySQL users](https://github.com/kenzor1979/auth-api/blob/main/img/MySQLusers.png?raw=true&sanitize=true)