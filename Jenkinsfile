pipeline
{
    agent { label 'global' }

    environment
    {
        IMAGE_BUILD_VERSION = "1.0.${env.BUILD_NUMBER}"
    }

    stages
    {
        stage('Checkout')
        {
            agent { label 'global' }
            steps
            {
                checkout scm
            }
        }

        stage('Docker Build') {
            agent { label 'global' }
            steps
            {
              sh """#!/bin/bash

              set -e -o pipefail

              docker build \
                --network=host \
                -t pkchuyen/kratest:${env.IMAGE_BUILD_VERSION} \
                -t pkchuyen/kratest:latest \
                -f docker/Dockerfile .

              # I just leave the simple docker login here, depends on what docker registry we use, we may have a difference ways to authticate with it before pushing the docker image
              docker login

              docker push pkchuyen/kratest:${env.IMAGE_BUILD_VERSION}
              docker push pkchuyen/kratest:latest
              """
            }
        }

        stage('Deploy') {
            agent { label 'global' }
            steps
            {
              sh """#!/bin/bash

              set -e -o pipefail

              # authenticate with k8s cluster. I put GKE here as example
              gcloud --quiet config set project project-name && gcloud --quiet container clusters get-credentials gke-cluster --zone europe-west1

              # update the app version
              sed -i -e "s/__APP_VERSION__/${env.IMAGE_BUILD_VERSION}/g" k8s/statefulset.yaml

              # deploy statefulset
              kubectl apply -f k8s/statefulset.yaml
              """
            }
        }
    }
}