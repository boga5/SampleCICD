node{

//GitSCM checkout
	stage ('Checkout') {
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/boga5/SampleCICD.git']]])
  }

//Build and SonarQube Analysis
  stage ('Build') {
		//withSonarQubeEnv {
			def mvn_version = 'maven'
			echo "${mvn_version}"
			withEnv( ["PATH+MAVEN=${tool mvn_version}/bin"] ) {
				sh "mvn clean install -Dbuild.number=${BUILD_NUMBER} -Dmaven.test.skip=true"
				}
		//}
	}

//Docker Image Build	
  stage ('Docker Build') {
    sh ''' sudo docker build -t 10.240.17.12:5043/sample-1.1.0 .'''
  }

	//Docker Image Tag
	stage ('Docker Tag') {
	    		//sh '''sudo docker image tag ${boga} 10.240.17.12:5043/sample-1.1.0'''
		//docker.withRegistry("https://10.240.17.12:5043", '4c82b77f-680b-4e99-8b1f-30a263f98e21'){
		//def customImage = docker.image('10.240.17.12:5043/sample-1.1.0')
		//customImage.push()
    sh '''sudo docker ps'''
		//}
	}

	//Hosting Docker container
	stage ('Docker Deployment') {
		sh '''#!/bin/bash
		Container_status=`sudo docker ps -a | grep "SampleCICD"`

		if [ ! -z "$Container_status" ];
		then
			sudo docker rm SampleCICD -f
		fi
		sudo docker run -it -d --name SampleCICD --privileged=true -p 6050:6400 --add-host=dbserver:192.168.13.14 -v /tmp/logs/lms/logs:/logs -v /tmp/logs/lms/configs:/configs 10.240.17.12:5043/sample-1.1.0'''
	}

/*
//Docker compose up
stage ('Docker Compose') {
    sh '''sudo docker-compose up'''
}
*/

/* //Certificate Issue for Deploying Artifacts
	stage ('Deploy Artifacts') {
	def server = Artifactory.newServer url: 'https://padlcicdggk4.sw.fortna.net/artifactory/webapp/', credentialsId: '067a8aaf-47b1-4cb4-99a0-44bcfd01bbc9'
	def buildInfo = Artifactory.newBuildInfo()
	buildInfo.env.capture = true
	def rtMaven = Artifactory.newMavenBuild()
	//rtMaven.tool = MAVEN_TOOL // Tool name from Jenkins configuration
	//rtMaven.opts = "-Denv=dev"
	rtMaven.deployer releaseRepo:'develop-release', snapshotRepo:'develop-snapshot', server: server
	rtMaven.resolver releaseRepo:'develop-release', snapshotRepo:'develop-snapshot', server: server
	//rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
	buildInfo.retention maxBuilds: 10, maxDays: 7, deleteBuildArtifacts: true
	//Publish build info.
	server.publishBuildInfo buildInfo
	}

//code ends here */

//Robot Framework Test cases execution
	stage ('RFW') {
    //notifySuccessful()
    sh '''
        sleep 10s
        chmod 774 ./robot/robot.sh 
        sudo sh ./robot/robot.sh 52.67.84.183 6050 192.168.13.14
    '''
    step([$class: 'RobotPublisher',
  	outputPath: '.',
  	passThreshold: 50,
  	unstableThreshold: 50,
  	otherFiles: ""])

/* RFW EXECUTION CODE
  sh '''sleep 20s
	pybot --variable hostname:52.67.84.183 --variable port:6050 --variable dbConnectionStr:192.168.13.14 tests/sampletest.robot'''
	*/
  }
}
