pipeline {
  agent any
    stages {
	    stage('Build') {
         sh 'mvn clean package'
         }
	 
	     stage('Publish') {
	 
         steps {
              sh """
                env | sort
                pwsh -NoProfile -NoLogo -NonInteractive -File ./Build/build.ps1 -ResolveDependency -TaskList Publish
              """

              sh '''
                   az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
                   az account set -s $AZURE_SUBSCRIPTION_ID
               '''
               }
               sh "az functionapp deployment source config-zip -g $RESOURCE_GROUP -n $FUNC_NAME --src archive.zip"
               sh 'az logout'
         }
     }
 }
 
 }
