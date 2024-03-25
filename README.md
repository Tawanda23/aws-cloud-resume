
# AWS Cloud Resume 

## Overview
This repository showcases my attempt at creating an AWS Cloud Resume in a multi-step project designed to demonstrate fundamental skills I have learnt over the past year. 


### Services Used:
- **S3 (Simple Storage Service)**: Used to store static website files, such as HTML, CSS, and JavaScript.
- **AWS CloudFront**: A content delivery network (CDN) service that accelerates the delivery of website content to users worldwide.
- **Amazon Certificate Manager (ACM)**: Provides SSL/TLS certificates for securing communication between clients and the CloudFront distribution.
- **AWS Lambda**: A serverless compute service used for running code in response to events, such as HTTP requests.
- **DynamoDB**: A NoSQL database service used for storing dynamic data, such as user information or application settings.
- **GitHub Actions**: Used for automating workflows, such as deploying changes to the website whenever there's a new commit to the GitHub repository.
- **Terraform**: Infrastructure as code will be used for provisioning and managing AWS resources in a repeatable and automated manner.

## Getting Started
To get started with this project, follow these steps:

1. Clone this repository to your local machine.
2. Install Terraform and configure your AWS credentials.
3. Modify the Terraform configuration files (`*.tf`) to customize the infrastructure according to your requirements.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform apply` to apply the Terraform configuration and provision the AWS resources.
6. Deploy your website files to the S3 bucket.
7. Test the functionality of your website and make any necessary adjustments.


