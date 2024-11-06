import 'package:sqflite/sqflite.dart';

import '../../models/questions.dart';

class AppDatabase {
  static Database? _database;

  static final AppDatabase instance = AppDatabase._init();

  AppDatabase._init();

  Future<Database> get database async {
    _database ??= await openDatabase('appdatabase.db',
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS Questions (
    question_id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT NOT NULL,
    answer_index INTEGER NOT NULL,
    options TEXT NOT NULL,
    certification_code TEXT NOT NULL )
    """);
    for (var i = 0; i < 10; i++) {
      await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options, certification_code) VALUES ('AWS allows users to manage their resources using a web based user interface. What is the name of this interface?', 3, 'A. AWS CLI,B. AWS API,C. AWS SDK,D. AWS Management Console', 'AWS-CCP')
    """);
    }
    for (var i = 0; i < 10; i++) {
      await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options, certification_code) VALUES ('Google allows users to manage their resources using a web based user interface. What is the name of this interface?', 3, 'A. Google CLI,B. Google API,C. Google SDK,D. Google Management Console', 'GCP-ACE')
    """);
    }

/*    for (var i = 0; i < 10; i++) {
      await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options, certification_code) VALUES ('Microsoft Azure allows users to manage their resources using a web based user interface. What is the name of this interface?', 3, 'A. Microsoft Azure CLI,B. Microsoft Azure API,C. Microsoft Azure SDK,D. Microsoft Azure Management Console', 'AZ-900')
    """);
    }*/
  }

/*  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS Questions (
    question_id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT NOT NULL,
    answer_index INTEGER NOT NULL,
    options TEXT NOT NULL,
    certification_code TEXT NOT NULL)
    """);
    await db.execute("""
INSERT INTO Questions (question_text, answer_index, options, certification_code) VALUES
('Which AWS service provides a content delivery network to distribute content globally with low latency?', 1, 'A. AWS RDS,B. Amazon CloudFront,C. AWS S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What type of pricing model does AWS use to charge customers?', 2, 'A. Fixed subscription,B. Pay-as-you-go,C. Contract-based,D. Usage-based with fixed fees', 'AWS-CCP'),
('What is the primary benefit of Amazon S3?', 1, 'A. Compute power,B. Scalable storage,C. Networking,D. Database management', 'AWS-CCP'),
('Which service is used for monitoring AWS resources?', 0, 'A. Amazon CloudWatch,B. Amazon EC2,C. AWS Lambda,D. Amazon RDS', 'AWS-CCP'),
('What is the AWS tool that automates infrastructure provisioning?', 1, 'A. AWS CloudTrail,B. AWS CloudFormation,C. AWS CloudWatch,D. AWS Config', 'AWS-CCP'),
('Which AWS service is a managed NoSQL database?', 2, 'A. Amazon RDS,B. Amazon Redshift,C. Amazon DynamoDB,D. Amazon Aurora', 'AWS-CCP'),
('Which AWS service helps you manage user access and permissions securely?', 0, 'A. AWS Identity and Access Management (IAM),B. AWS CloudTrail,C. AWS Config,D. AWS Trusted Advisor', 'AWS-CCP'),
('Which AWS service is used for object storage?', 2, 'A. Amazon EBS,B. Amazon S3 Glacier,C. Amazon S3,D. AWS Snowball', 'AWS-CCP'),
('What is the primary benefit of using AWS Lambda?', 3, 'A. Infrastructure management,B. Instance management,C. Server management,D. Serverless computing', 'AWS-CCP'),
('Which AWS service can you use to send notifications?', 0, 'A. Amazon SNS,B. Amazon SES,C. Amazon SQS,D. AWS Batch', 'AWS-CCP'),
('Which service helps you track and manage costs in AWS?', 1, 'A. AWS Cost Explorer,B. AWS CloudWatch,C. AWS Budgets,D. AWS Config', 'AWS-CCP'),
('What does Amazon Elastic Compute Cloud (EC2) provide?', 2, 'A. Network management,B. Data storage,C. Virtual servers,D. Content delivery', 'AWS-CCP'),
('Which AWS service is used for real-time streaming data?', 3, 'A. AWS Data Pipeline,B. AWS Batch,C. AWS Glue,D. Amazon Kinesis', 'AWS-CCP'),
('What does AWS CloudTrail do?', 0, 'A. Tracks user activity and API usage,B. Automates resource provisioning,C. Manages databases,D. Provides content delivery', 'AWS-CCP'),
('Which AWS service helps with infrastructure as code?', 1, 'A. AWS CloudTrail,B. AWS CloudFormation,C. AWS Glue,D. AWS Lambda', 'AWS-CCP'),
('What is the main function of AWS Elastic Beanstalk?', 1, 'A. Managing security,B. Deploying and managing applications,C. Monitoring applications,D. Storing large datasets', 'AWS-CCP'),
('Which AWS database service is relational?', 0, 'A. Amazon RDS,B. Amazon DynamoDB,C. Amazon Redshift,D. AWS CloudSearch', 'AWS-CCP'),
('Which AWS service is designed for data warehousing?', 2, 'A. Amazon S3,B. Amazon DynamoDB,C. Amazon Redshift,D. AWS Glue', 'AWS-CCP'),
('What is Amazon VPC used for?', 3, 'A. Content delivery,B. Data analytics,C. Database management,D. Network isolation', 'AWS-CCP'),
('Which service provides a secure environment to run containers?', 0, 'A. Amazon ECS,B. AWS Lambda,C. AWS Fargate,D. Amazon EMR', 'AWS-CCP'),
('What is the main advantage of AWS Auto Scaling?', 1, 'A. Cost reduction,B. Handling variable workloads,C. Enhanced security,D. Improved storage', 'AWS-CCP'),
('Which AWS service helps deploy machine learning models?', 2, 'A. AWS Lambda,B. AWS CloudFormation,C. Amazon SageMaker,D. Amazon Rekognition', 'AWS-CCP'),
('What does AWS CloudFront offer?', 2, 'A. Storage solutions,B. Compute resources,C. Content delivery,D. Machine learning', 'AWS-CCP'),
('Which service is used to handle large-scale data processing?', 0, 'A. Amazon EMR,B. AWS Batch,C. AWS Lambda,D. Amazon SNS', 'AWS-CCP'),
('What is the primary use of Amazon RDS?', 1, 'A. Scalable storage,B. Managed relational database,C. Networking,D. Machine learning', 'AWS-CCP'),
('Which AWS service provides durable, low-cost data archiving?', 3, 'A. Amazon S3,B. Amazon EFS,C. Amazon RDS,D. Amazon S3 Glacier', 'AWS-CCP'),
('What is the AWS service for managed Kubernetes?', 0, 'A. Amazon EKS,B. Amazon ECS,C. AWS Fargate,D. AWS Lambda', 'AWS-CCP'),
('Which service helps you build and deploy applications using a web-based console?', 1, 'A. AWS CloudFormation,B. AWS Amplify,C. AWS CodeBuild,D. AWS CodePipeline', 'AWS-CCP'),
('Which AWS service enables you to run code without provisioning or managing servers?', 0, 'A. AWS Lambda,B. Amazon ECS,C. AWS Fargate,D. AWS Batch', 'AWS-CCP'),
('Which AWS service allows you to connect your on-premises environment to the AWS cloud securely?', 3, 'A. AWS Snowball,B. AWS VPN,C. AWS DataSync,D. AWS Direct Connect', 'AWS-CCP'),
('What is the AWS service that provides scalable file storage in the cloud?', 1, 'A. Amazon S3,B. Amazon EFS,C. Amazon RDS,D. Amazon Glacier', 'AWS-CCP'),
('Which AWS service can you use to automate software deployments to a variety of compute services?', 2, 'A. AWS CodePipeline,B. AWS CodeBuild,C. AWS CodeDeploy,D. AWS CloudFormation', 'AWS-CCP'),
('Which service allows you to create and manage a collection of related AWS resources?', 1, 'A. AWS CloudTrail,B. AWS CloudFormation,C. AWS Glue,D. AWS Lambda', 'AWS-CCP'),
('Which AWS service is a fully managed source control service?', 0, 'A. AWS CodeCommit,B. AWS CodePipeline,C. AWS CodeBuild,D. AWS CodeDeploy', 'AWS-CCP'),
('What is Amazon Lightsail used for?', 2, 'A. Data warehousing,B. Big data processing,C. Simple web applications,D. Container orchestration', 'AWS-CCP'),
('Which service helps you manage the lifecycle of your AWS resources?', 3, 'A. AWS CloudWatch,B. AWS Config,C. AWS CloudTrail,D. AWS Service Catalog', 'AWS-CCP'),
('What is the AWS service for hosting a static website?', 0, 'A. Amazon S3,B. Amazon EC2,C. AWS Lambda,D. AWS Fargate', 'AWS-CCP'),
('Which AWS service offers fast, reliable block storage?', 1, 'A. Amazon S3,B. Amazon EBS,C. Amazon EFS,D. AWS Snowball', 'AWS-CCP'),
('What is the primary benefit of AWS Elastic Load Balancing?', 2, 'A. Cost reduction,B. Improved security,C. Distributing incoming application traffic,D. Enhanced data storage', 'AWS-CCP'),
('Which AWS service is used to run Docker containers?', 3, 'A. Amazon S3,B. AWS Lambda,C. Amazon VPC,D. Amazon ECS', 'AWS-CCP'),
('What is the main feature of AWS CloudFormation?', 1, 'A. Cost management,B. Infrastructure as code,C. Network management,D. Application monitoring', 'AWS-CCP'),
('Which AWS service is designed for data lake creation?', 2, 'A. Amazon RDS,B. Amazon Redshift,C. AWS Lake Formation,D. AWS Glue', 'AWS-CCP'),
('What is the use of Amazon CloudWatch?', 0, 'A. Monitoring AWS resources,B. Managing identities,C. Content delivery,D. Database management', 'AWS-CCP'),
('Which service provides distributed denial-of-service (DDoS) protection?', 3, 'A. AWS WAF,B. AWS IAM,C. AWS Config,D. AWS Shield', 'AWS-CCP'),
('What does Amazon Route 53 offer?', 2, 'A. Compute power,B. Data storage,C. Domain name system (DNS) service,D. Content delivery', 'AWS-CCP'),
('Which AWS service provides a managed database service?', 1, 'A. Amazon RDS,B. Amazon EC2,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the primary use of Amazon EC2?', 0, 'A. Storage,B. Networking,C. Compute,D. Database', 'AWS-CCP'),
('What is the purpose of AWS IAM?', 2, 'A. Identity and Access Management,B. Infrastructure as Code,C. Continuous Integration/Continuous Delivery,D. Serverless Computing', 'AWS-CCP'),
('What is the core concept of AWS Lambda?', 1, 'A. Serverless computing,B. Container orchestration,C. Data warehousing,D. Machine learning', 'AWS-CCP'),
('Which AWS service is used for deploying and managing applications on AWS?', 3, 'A. Amazon RDS,B. Amazon S3,C. AWS Lambda,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS VPC?', 0, 'A. Virtual Private Cloud,B. Virtual Private Server,C. Virtual Private Network,D. Virtual Private Database', 'AWS-CCP'),
('Which AWS service is used for object storage?', 2, 'A. Amazon EC2,B. Amazon RDS,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Security Groups?', 1, 'A. Network security,B. Data security,C. Application security,D. User security', 'AWS-CCP'),
('Which AWS service is used for load balancing?', 3, 'A. Amazon EC2,B. Amazon RDS,C. Amazon S3,D. AWS Elastic Load Balancing', 'AWS-CCP'),
('What is the primary use of AWS CloudFormation?', 2, 'A. Infrastructure as Code,B. Serverless computing,C. Data warehousing,D. Machine learning', 'AWS-CCP'),
('Which AWS service is used for data warehousing and analytics?', 1, 'A. Amazon Redshift,B. Amazon DynamoDB,C. Amazon RDS,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Key Management Service (KMS)?', 0, 'A. Key management and encryption,B. Identity and access management,C. Network security,D. Data security', 'AWS-CCP'),
('Which AWS service is used for real-time analytics and data processing?', 2, 'A. Amazon Redshift,B. Amazon Kinesis,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Identity and Access Management (IAM)?', 3, 'A. Manage users, groups, and roles,B. Secure network traffic,C. Encrypt data at rest,D. Monitor system health', 'AWS-CCP'),
('Which AWS service is used for serverless application development?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Simple Notification Service (SNS)?', 0, 'A. Messaging and notifications,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for caching database queries?', 2, 'A. Amazon ElastiCache,B. Amazon RDS,C. Amazon DynamoDB,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Simple Queue Service (SQS)?', 1, 'A. Message queuing,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for deploying and managing containerized applications?', 3, 'A. Amazon EC2,B. Amazon RDS,C. Amazon S3,D. Amazon ECS', 'AWS-CCP'),
('What is the purpose of AWS CloudTrail?', 2, 'A. Logging and monitoring API calls,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and automating infrastructure provisioning?', 1, 'A. AWS CloudFormation,B. Amazon EC2,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Config?', 0, 'A. Configuration management and compliance,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for serverless data processing?', 2, 'A. Amazon EMR,B. Amazon Redshift,C. AWS Lambda,D. Amazon S3', 'AWS-CCP'),
('What is the purpose of AWS Systems Manager?', 1, 'A. Systems management and automation,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for high-performance computing?', 3, 'A. Amazon EC2,B. Amazon RDS,C. Amazon S3,D. AWS Batch', 'AWS-CCP'),
('What is the purpose of AWS WAF?', 0, 'A. Web application firewall,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless functions?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Direct Connect?', 2, 'A. Dedicated network connection to AWS,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for disaster recovery and business continuity?', 3, 'A. Amazon EC2,B. Amazon RDS,C. Amazon S3,D. AWS Backup', 'AWS-CCP'),
('What is the purpose of AWS Organizations?', 1, 'A. Managing multiple AWS accounts,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless containers?', 2, 'A. Amazon ECS,B. Amazon EKS,C. AWS Lambda,D. AWS Fargate', 'AWS-CCP'),
('What is the purpose of AWS CodePipeline?', 0, 'A. Continuous delivery pipeline,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying infrastructure as code?', 1, 'A. AWS CloudFormation,B. Amazon EC2,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS CodeBuild?', 2, 'A. Continuous integration and continuous delivery,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for monitoring and logging AWS resources?', 0, 'A. Amazon CloudWatch,B. Amazon EC2,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS X-Ray?', 1, 'A. Application performance monitoring,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for securing network traffic between VPCs?', 2, 'A. AWS WAF,B. AWS Shield,C. AWS VPN,D. AWS Transit Gateway', 'AWS-CCP'),
('What is the purpose of AWS Shield?', 0, 'A. Distributed denial-of-service (DDoS) protection,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Glue?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying machine learning models?', 3, 'A. Amazon SageMaker,B. Amazon Rekognition,C. Amazon Comprehend,D. Amazon Polly', 'AWS-CCP'),
('What is the purpose of AWS IoT Core?', 1, 'A. Device connectivity and management,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless containers?', 2, 'A. Amazon ECS,B. Amazon EKS,C. AWS Lambda,D. AWS Fargate', 'AWS-CCP'),
('What is the purpose of AWS Step Functions?', 0, 'A. Visual workflow for serverless applications,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS AppSync?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS CloudWatch Logs?', 1, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for monitoring and logging AWS resources?', 3, 'A. Amazon CloudWatch,B. Amazon EC2,C. Amazon S3,D. AWS Lambda', 'AWS-CCP'),
('What is the purpose of AWS Config?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS CloudTrail?', 0, 'A. Monitoring and logging for security events,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS CloudFormation?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Lambda?', 0, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Elastic Beanstalk?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Elastic Container Service (ECS)?', 0, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Elastic Kubernetes Service (EKS)?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Elastic Beanstalk?', 0, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 1, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP'),
('What is the purpose of AWS Elastic Beanstalk?', 2, 'A. Serverless data integration and ETL,B. Data warehousing,C. Machine learning,D. Serverless computing', 'AWS-CCP'),
('Which AWS service is used for managing and deploying serverless applications?', 3, 'A. AWS Lambda,B. Amazon EC2,C. Amazon S3,D. AWS Elastic Beanstalk', 'AWS-CCP');
    """);
  }*/

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await _onCreate(db, newVersion);
    }
  }

  Future<void> insertQuestion(Question question) async {
    final db = await database;
    await db.insert(
      'Questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

/*  Future<List<Question>> getQuestionsByCertification(String certificationCode) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Questions',
      where: 'certification_code = ?',
      whereArgs: [certificationCode],
    );
    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }*/

  Future<List<Question>> getQuestions(String certificationCode) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Questions',
      where: 'certification_code = ?',
      whereArgs: [certificationCode],
    );

    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
