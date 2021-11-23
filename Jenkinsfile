pipeline {
  agent any
    stages {
	    stage('Build') {
         sh 'mvn clean package'
         }
	 
	     stage('Publish') {
	 
		 steps {
		      
		      azureCLI commands: [[exportVariablesString: '', script: 'az login']], principalCredentialId: 'Jenkins-sp'
			
		       }
		     
		       azureCLI commands: [[exportVariablesString: '', script: 'az deployment sub create --l WestUS -f ./BicepFiles/main.bicep"']], principalCredentialId: 'Jenkins-sp'
		       sh 'az logout'
		     
         		}
     		}
  
 }
