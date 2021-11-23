pipeline {
  agent any
    stages {
	    	 
	     stage('Deploy') {
	 
		 steps {
		     
		       azureCLI commands: [[exportVariablesString: '', script: 'az deployment sub create --l WestUS -f ./BicepFiles/main.bicep"']], principalCredentialId: 'Jenkins-sp'
		 }
		     
         		}
     		}
  
 }
