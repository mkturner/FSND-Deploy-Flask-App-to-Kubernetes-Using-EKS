# Deploying a Flask API

This is the project repo for the fourth of five projects in the [Udacity Full Stack Nanodegree](https://www.udacity.com/course/full-stack-web-developer-nanodegree--nd004): Server Deployment, Containerization, and Testing.

The purpose of this project was to containerize and deploy a Flask API to a Kubernetes cluster using Docker, AWS EKS, CodePipeline, and CodeBuild.

The Flask app that will be used for this project consists of a simple API with three endpoints:

- `GET '/'`: This is a simple health check, which returns the response 'Healthy'. 
- `POST '/auth'`: This takes a email and password as json arguments and returns a JWT based on a custom secret.
- `GET '/contents'`: This requires a valid JWT, and returns the un-encrpyted contents of that token. 

The app relies on a secret set as the environment variable `JWT_SECRET` to produce a JWT. The built-in Flask server is adequate for local development, but not production, so [Gunicorn](https://gunicorn.org/) server was used when deploying on AWS.

## Initial setup
1. Clone this repo to serve the project.

## Dependencies

- Docker Engine
    - Installation instructions for all OSes can be found [here](https://docs.docker.com/install/).
    - **Mac users:** if you have no previous Docker Toolbox installation, you can install Docker Desktop for Mac. If you already have a Docker Toolbox installation, please read [this](https://docs.docker.com/docker-for-mac/docker-toolbox/) before installing.
 - AWS Account
     - You can create an AWS account by signing up [here](https://aws.amazon.com/#).
     
## Project Steps

Completing the project involves several steps:

1. Write a Dockerfile for a simple Flask API
2. Build and test the container locally
3. Create an EKS cluster
- Create cluster in the default region
>`eksctl create cluster --name simple-jwt-api`

- Create a cluster in a specific region, such as us-east-2
>`eksctl create cluster --name simple-jwt-api --region=us-east-2`
- Get AWS Account ID
>`aws sts get-caller-identity --query Account --output text`
- Update `conifgmap/aws-auth` with AWS ID and necessary permisisons

4. Store a secret using AWS Parameter Store
- Put secret into AWS Parameter Store
>`aws ssm put-parameter --name JWT_SECRET --overwrite --value "YourJWTSecret" --type SecureString`

- Once you receive project reviews, consider deleting the variable from parameter-store:
>`aws ssm delete-parameter --name JWT_SECRET`

5. Create a CodePipeline pipeline triggered by GitHub checkins
- Use the AWS MAnagement Console to navigate to CloudFormation and upload `ci-cd-codepipeline.cfn.yml` and create the stack
- be sure to generate and supply your [Github access token](https://github.com/settings/tokens)
- also be sure to check the IAM checkbox on the last page, or else CFN will not have necessary permisions
6. Create a CodeBuild stage which will build, test, and deploy your code
- make an edit and commit your change
- After a minute or two, check to see if the build was initiated


For more detail about each of these steps, see the project lesson [here](https://classroom.udacity.com/nanodegrees/nd004/parts/1d842ebf-5b10-4749-9e5e-ef28fe98f173/modules/ac13842f-c841-4c1a-b284-b47899f4613d/lessons/becb2dac-c108-4143-8f6c-11b30413e28d/concepts/092cdb35-28f7-4145-b6e6-6278b8dd7527).