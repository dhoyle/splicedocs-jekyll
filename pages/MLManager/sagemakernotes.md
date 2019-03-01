Amazon SageMaker is a fully managed machine learning service. With Amazon SageMaker, data scientists and developers can quickly and easily build and train machine learning models, and then directly deploy them into a production-ready hosted environment. It provides an integrated Jupyter authoring notebook instance for easy access to your data sources for exploration and analysis, so you don't have to manage servers. It also provides common machine learning algorithms that are optimized to run efficiently against extremely large data in a distributed environment. With native support for bring-your-own-algorithms and frameworks, Amazon SageMaker offers flexible distributed training options that adjust to your specific workflows. Deploy a model into a secure and scalable environment by launching it with a single click from the Amazon SageMaker console. Training and hosting are billed by minutes of usage, with no minimum fees and no upfront commitments.

https://docs.aws.amazon.com/sagemaker/

You can use Amazon SageMaker


How Deployment Works

	MLFlow, as I said before, provides capabilities to deploy any model it has stored inside its /mlruns directory to SageMaker. Since one of Splice Machine's slogan's is: The Data Platform for Intelligent Applications, a SageMaker integration would be very helpful for making that a reality. Although Splice Machine is very performant in training the models, SageMaker provides autoscaled model prediction endpoints running on EC2 instances.  Having a RESTful API which can be used for predictions is very helpful for allowing applications, such as mobile apps, using models trained in Splice Machine.

	To deploy, MLFlow packages our classifiers into Docker images, and then pushes them up to ECR. SageMaker will read the docker image from ECR, and deploy a prediction endpoint with that image. MLFlow, to push models to ECR and deploy to SageMaker, needs the ability to assume an IAM role called splice-sagemaker (full SageMaker access), and to have read/write access to both SageMaker and S3.

Bob the Builder- a humble worker

To take care of the deployment job, a new component was created— cleverly dubbed Bob the Builder by Murray. The name comes from MLFlow "building" the docker images and pushing them to ECR, the container's main task, similar to Bob the Builder.


MLFlow Deployment API

	To submit jobs to Bob the Builder (docker image: bobby), a RESTful API was implemented that accepts job metadata in the form of JSON via a POST request. This is running on /deploy. Obviously, deployment can happen in the same container, as the job is long running. Rather, we need to enqueue the job into some sort of queue. After considering several options, a Splice Machine table was selected as the best option.

Retraining

	Retraining, like deployment, is also a handler specified in the worker file in Bob the Builder. Retraining can either be triggered manually, via the /retrain endpoint, or it can be triggered automatically, via a metronome app (to be deployed), that will curl this endpoint with the JSON associated with it when it was created. The MLFlow artifact containing the pyspark model is deconstructed into an unfitted pipeline, and retrained on the same table, although this time, the table contains new information. To retrieve this data, a spark context will be established to connect to a cluster. The Run will be logged in MLFlow as well.



Worker

	The Worker is the piece of code in Bob the Builder that actually handles deployment. It reads the queue for jobs that are still pending (FIFO) and services them one at a time.

Here are the steps that the worker takes when it gets a new deployment job.

Do an S3 one-time sync with the MLFlow metadata bucket. No intermediate directory required, as we are not resyncing
In the Run directory, create a new conda.yaml file, containing the packages listed above (in Bob the Builder overview section)
Edit the MLmodel file in the artifacts directory to include env: conda.yaml
Using its access to ECR, build and push a new MLFlow docker container, packaging the model.
Using the assumed IAM Role, splice-sagemaker, deploy to SageMaker

Stop Service:
Disable the service in ML.ACTIVE_SERVICES

Start Service
Enable the service in ML.ACTIVE_SERVICES

Schedule Job
To be implemented: Start up a Metronome app which curls the /retrain endpoint with the correct metadata periodically

Stop Scheduled Job
To be implemented: Delete Metronome App

Retrain
One-time S3 Download sync (without intermediate directory)
Establish a SparkContext with jars from sm-base. Download site.xml files from HMaster upon container startup.
Deconstruct the fitted pipeline into an unfit pipeline object
Use the PySpliceContext (from splicemachine python package, in github.com/splicemachine/pysplice) ( need to figure out a way to make this work without having to store the table in this tiny container)
Train the pipeline
Evaluate it and take metrics
Check deployment threshold against metric if deployment mode is threshold (deploy if metric satisfies constraints). If mode is automatic, deploy, and if it is manual, don't deploy)
