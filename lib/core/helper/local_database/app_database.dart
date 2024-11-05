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
    options TEXT NOT NULL )
    """);
    for (var i = 0; i < 10; i++) {
      await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options) VALUES ('AWS allows users to manage their resources using a web based user interface. What is the name of this interface?', 3, 'A. AWS CLI,B. AWS API,C. AWS SDK,D. AWS Management Console')
    """);
    }
  }

/*  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS Questions (
    question_id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT NOT NULL,
    answer_index INTEGER NOT NULL,
    options TEXT NOT NULL )
    """);
    await db.execute("""
    INSERT INTO Questions (question_text, answer_index, options) VALUES
('Which AWS service provides a content delivery network to distribute content globally with low latency?', 1, 'A. AWS RDS,B. Amazon CloudFront,C. AWS S3,D. AWS Elastic Beanstalk'),
('What type of pricing model does AWS use to charge customers?', 2, 'A. Fixed subscription,B. Pay-as-you-go,C. Contract-based,D. Usage-based with fixed fees'),
('What is the primary benefit of Amazon S3?', 1, 'A. Compute power,B. Scalable storage,C. Networking,D. Database management'),
('Which service is used for monitoring AWS resources?', 0, 'A. Amazon CloudWatch,B. Amazon EC2,C. AWS Lambda,D. Amazon RDS'),
('Which AWS service provides a relational database managed by AWS?', 3, 'A. Amazon S3,B. Amazon EC2,C. AWS Lambda,D. Amazon RDS'),
('What is the purpose of Amazon VPC?', 0, 'A. To create an isolated network for resources,B. To manage databases,C. To store files,D. To monitor applications'),
('Which AWS service allows you to run code without provisioning or managing servers?', 2, 'A. Amazon EC2,B. Amazon RDS,C. AWS Lambda,D. AWS S3'),
('What does IAM stand for in AWS?', 2, 'A. Instant Access Management,B. Initial Account Management,C. Identity and Access Management,D. Identity Account Management'),
('Which service offers an interactive user interface for managing AWS resources?', 3, 'A. AWS CLI,B. AWS API,C. AWS SDK,D. AWS Management Console'),
('What is the main function of Amazon Route 53?', 0, 'A. Domain Name System (DNS) service,B. Web hosting,C. Security management,D. Network monitoring'),
('Which AWS service is used to analyze and visualize log data?', 1, 'A. Amazon RDS,B. Amazon CloudWatch Logs,C. Amazon VPC,D. AWS IAM'),
('Which tool provides billing and cost management in AWS?', 0, 'A. AWS Cost Explorer,B. AWS IAM,C. AWS Lambda,D. Amazon RDS'),
('What is the main use of Amazon EC2?', 1, 'A. Storage,B. Virtual server hosting,C. Networking,D. Data analytics'),
('Which service provides managed DDoS protection?', 2, 'A. AWS Shield Advanced,B. AWS VPC,C. AWS Shield,D. AWS IAM'),
('What is a key feature of Amazon RDS?', 3, 'A. Object storage,B. Content delivery,C. Security,D. Managed relational databases'),
('Which AWS service provides scalable object storage?', 0, 'A. Amazon S3,B. Amazon EC2,C. AWS Lambda,D. Amazon DynamoDB'),
('Which AWS service helps with setting up a private network for your AWS resources?', 0, 'A. Amazon VPC,B. Amazon CloudFront,C. AWS Lambda,D. AWS S3'),
('Which AWS service offers distributed denial of service (DDoS) protection?', 2, 'A. Amazon CloudFront,B. Amazon RDS,C. AWS Shield,D. Amazon S3'),
('What does Amazon S3 stand for?', 1, 'A. Simple Storage Service,B. Secure Storage Service,C. Storage Support System,D. Scalable Storage Solution'),
('Which AWS service is used for deploying and managing containers?', 0, 'A. Amazon ECS,B. AWS Lambda,C. Amazon S3,D. Amazon RDS'),
('Which AWS service is used for machine learning model training and deployment?', 1, 'A. AWS Lambda,B. Amazon SageMaker,C. Amazon RDS,D. AWS S3'),
('Which AWS service provides serverless computing?', 2, 'A. Amazon EC2,B. Amazon RDS,C. AWS Lambda,D. Amazon S3'),
('Which AWS service provides a managed NoSQL database?', 0, 'A. Amazon DynamoDB,B. Amazon RDS,C. Amazon EC2,D. AWS S3'),
('What is the main purpose of Amazon CloudFront?', 3, 'A. Data storage,B. Compute power,C. Network isolation,D. Content delivery'),
('Which service allows users to manage user permissions and credentials?', 0, 'A. AWS IAM,B. AWS S3,C. Amazon CloudWatch,D. AWS Lambda'),
('Which AWS service offers a database for document-based data models?', 1, 'A. Amazon RDS,B. Amazon DynamoDB,C. AWS Lambda,D. Amazon S3'),
('What type of database is Amazon DynamoDB?', 3, 'A. Relational,B. SQL-based,C. In-memory,D. NoSQL'),
('Which AWS service would you use to store large amounts of data at low cost?', 2, 'A. Amazon RDS,B. AWS Lambda,C. Amazon S3,D. AWS IAM'),
('Which AWS service helps secure your applications from DDoS attacks?', 1, 'A. Amazon EC2,B. AWS Shield,C. Amazon S3,D. Amazon VPC'),
('Which AWS service allows you to host a scalable web application?', 2, 'A. Amazon CloudWatch,B. AWS IAM,C. Amazon EC2,D. AWS Lambda'),
('What is the primary use of Amazon RDS?', 1, 'A. Object storage,B. Relational database hosting,C. Network management,D. Content delivery'),
('Which AWS service helps detect unauthorized activity in your account?', 2, 'A. AWS IAM,B. AWS S3,C. Amazon GuardDuty,D. Amazon RDS'),
('What does Amazon S3 Glacier offer?', 3, 'A. Real-time data access,B. Web hosting,C. Fast file retrieval,D. Long-term, low-cost storage'),
('What is a benefit of using AWS Lambda?', 1, 'A. Persistent storage,B. Serverless architecture,C. Managed databases,D. Virtual networking'),
('What is Amazon EBS used for?', 0, 'A. Persistent storage for EC2 instances,B. DNS management,C. Content delivery,D. NoSQL database hosting'),
('Which AWS service is used to securely connect an on-premises network to AWS?', 2, 'A. Amazon S3,B. AWS Lambda,C. AWS Direct Connect,D. Amazon CloudFront'),
('What is Amazon CloudTrail primarily used for?', 0, 'A. Tracking API calls and user actions,B. Serverless computing,C. Content delivery,D. Database management'),
('Which AWS service is used for real-time data processing?', 2, 'A. AWS IAM,B. AWS RDS,C. Amazon Kinesis,D. AWS S3'),
('What type of storage does Amazon S3 provide?', 1, 'A. Block storage,B. Object storage,C. File storage,D. Archival storage'),
('Which AWS service helps detect and analyze security threats?', 3, 'A. AWS S3,B. AWS IAM,C. AWS Lambda,D. Amazon GuardDuty'),
('What does the AWS Free Tier provide?', 1, 'A. Unlimited free services,B. Limited-time free usage of some services,C. No-cost access to premium features,D. Always free, unlimited usage of resources'),
('Which service is a fully managed data warehouse in AWS?', 2, 'A. Amazon RDS,B. Amazon S3,C. Amazon Redshift,D. AWS Lambda'),
('Which AWS service can distribute traffic across multiple EC2 instances?', 3, 'A. Amazon S3,B. AWS RDS,C. Amazon VPC,D. Elastic Load Balancing'),
('What is a benefit of using Amazon EC2 Auto Scaling?', 0, 'A. Automatically adjust capacity to demand,B. Host static websites,C. Run serverless code,D. Manage user accounts'),
('What is the purpose of Amazon SNS?', 2, 'A. Database hosting,B. Virtual server hosting,C. Sending notifications,D. Content delivery'),
('Which AWS service offers version control for code?', 0, 'A. AWS CodeCommit,B. AWS Lambda,C. AWS S3,D. Amazon RDS'),
('Which tool helps optimize AWS costs by providing recommendations?', 3, 'A. Amazon RDS,B. Amazon S3,C. AWS Lambda,D. AWS Trusted Advisor'),
('What is the function of Amazon S3 Glacier?', 1, 'A. High-speed data access,B. Archival storage,C. Object storage,D. DNS management'),
('What AWS service provides managed MySQL databases?', 3, 'A. Amazon CloudFront,B. AWS S3,C. AWS Lambda,D. Amazon RDS'),
('Which service helps establish a private network within AWS?', 0, 'A. Amazon VPC,B. Amazon RDS,C. Amazon S3,D. Amazon DynamoDB'),
('What is the main purpose of Amazon EC2?', 1, 'A. Content delivery,B. Hosting virtual servers,C. Data storage,D. User authentication'),
('What is Amazon Athena primarily used for?', 2, 'A. Managed database,B. Content delivery,C. Querying data in Amazon S3,D. Virtual servers'),
('What is the purpose of AWS CloudFormation?', 3, 'A. Database management,B. Storage service,C. Data analytics,D. Infrastructure as code'),
('Which AWS service provides file storage for EC2 instances?', 1, 'A. Amazon S3,B. Amazon EFS,C. Amazon RDS,D. AWS Lambda'),
('What is the main function of AWS Elastic Beanstalk?', 3, 'A. Storage,B. Content delivery,C. DNS management,D. Application deployment and management'),
('Which AWS service helps you manage secrets such as database credentials?', 0, 'A. AWS Secrets Manager,B. AWS Lambda,C. Amazon RDS,D. Amazon VPC')
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

  Future<List<Question>> getQuestions() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('Questions');

    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
