@ Library ("Shared") _

pipeline{    
    agent {label "Jenkins-Slave"}
    
    stages{ 
        stage("Hello"){
            steps{
                script{
                    hello()
                }
            }
        }
        
        stage("Code"){
            
            steps {
                
                script{
                clone("https://github.com/visaltyagi/django-notes-app.git","main")
                }     
            }
            
        }
        
        stage("Build"){
            
            steps{
               sh "docker pull mysql:5.7"
               script {
               docker_build("django_app", "latest", "visaltyagi12")
               docker_build("nginx", "1.23.3-alpine", "visaltyagi12")
               }
            }
        }
        
        stage("Test"){
            
            steps{
                
                echo "This is testing the code"
            }   
        }
        
        stage("Push to the DockerHub"){
             
            steps {
                
                  script{
                  docker_push("django_app", "latest", "visaltyagi12")
                  docker_push("nginx", "1.23.3-alpine", "visaltyagi12")
                  }
            }
        }
        stage("Deploy"){
            
            steps{
                echo "This is deploying the code."
                sh "docker compose up -d"
                
            }                   
        }
    }
}
