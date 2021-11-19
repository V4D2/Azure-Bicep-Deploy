pipeline {
  agent any
    stages {
	    stage('Build') {
         sh 'mvn clean package'
         }
	 
	     stage('Publish') {
	 
		 steps {
		      
		      sh '''
			   az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
			   az account set -s $AZURE_SUBSCRIPTION_ID
		       '''
		       }
		     
		       sh "az deployment sub create --l WestUS -f ./BicepFiles/AzurePolicy.bicep"
		       sh 'az logout'
		     
         		}
     		}
  
 }
