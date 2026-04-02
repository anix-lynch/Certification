# Week 3 Assignment:<br>Good Data Architecture

Welcome to week 3 lab! In this lab, you will explore and assess the security, performance, reliability, and scalability aspects of a 
web application hosted on AWS. You will do this by simulating traffic to your web application and using AWS tools such as Amazon CloudWatch 
to monitor computing resources and network activity on your web application. 
You will configure the computing resources to enable performance efficiency, as well as security options to control the in-bound 
traffic to your web application. You will perform these tasks through the principles of “good” data architecture as well as the lenses of AWS Well-Architected Framework.
By going through this lab, you will gain an understanding of the primitive resources available on AWS, so that you can later apply 
this understanding when you architect your data pipelines as a Data Engineer.

# Table of Contents
- [1 - Introduction](#1)
- [2 - Getting the Address of the Web Application](#2)
- [3 - Monitoring CPU Usage and Networking Activity](#3)
- [4 - Enhancing Security](#4)
- [5 - Checking EC2 Availability](#5)
- [6 - Performing Auto Scaling](#6)
    - [6.1 - Using Resources Efficiently](#6-1)
    - [6.2 - Performing Auto Scaling](#6-2)

---

<div id='1'/>

## 1 - Introduction

In week 2, you implemented a data pipeline where you ingested and transformed data and then served it to a data analyst.

![image alt ><](./images/ETL.drawio.png)

Assume now you built a similar data pipeline to serve the transformed data to a broader public. For example, assume your company sells some analytical
data and makes it available to people across the internet. Or, assume it needs to serve some embedded dashboards to its clients. To do so, you will need 
to build a web application that makes the data or dashboards available to their intended clients and that is capable of scaling to their needs. In this lab, 
you will focus on this component of your data architecture (the web app) to assess its security, performance, reliability, and scalability.

How is the web application created? A typical way of deploying web application solutions is to use a [three-tier-architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html) that consists of three tiers or layers:

![image alt ><](./images/ThreeTierArchitecture.png)

- **Presentation tier**: this tier represents the user interface of the website (ex.: a web page) that allows clients to interact with the web application using 
their devices. This is where you can display the analytical dashboards for clients.
- **Logic tier**: this tier, also known as the application tier, represents the business logic that processes clients' input, queries the internal data stores and 
returns the results that need to be displayed on the presentation layer.
- **Data tier**: this tier is where the data associated with the web application is stored.

Here the three-tier architecture of your web application is given to you, and you’ll mainly interact with the computing resources on which the application logic is run. Here’s the architectural diagram of the web application:

![image alt ><](./images/de-c1w3.drawio.png)

On the left side, you see S3 which represents the data store of the data layer, just as an example of a data tier. On the right side, you see the clients 
that interact with the website through their devices. The other two main components are **Application Load Balancer (ALB)** and **Auto Scaling group** which 
both operate at the application layer:

- [Amazon EC2 Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html): this group consists of a 
collection of EC2 instances. What is an EC2 instance? This is the application server on which your application logic runs. It mainly consists of 
Central Processing Unit (CPU) and Random Access Memory (RAM). Think of EC2 as a computer that is provided by AWS on which you will run your code. 
Now why do you have more than one EC2? Each EC2 runs the same logic and they are used to increase the computing capabilities of your application. 
So instead of having a single EC2 that processes all inputs or requests from clients, these inputs are distributed across the EC2 instances. 
**Auto-scaling** means that the number of EC2 instances can increase or decrease based on the demand. In this case it is the client’s inputs or requests to the web app.

- [Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/what-is-load-balancing.html): The Auto Scaling group is associated 
with an application load balancer, which distributes incoming application traffic (clients requests’ or inputs) across the EC2 instances. The load balancer serves as the single point of contact for clients.

In the diagram, you also see two terms: **Virtual Private Cloud (VPC)** and **subnet**. VPC is a way to isolate your resources (for example EC2) from the outside world. 
Think about it as a box or a wall that protects your resources, and also as a way to organize them. Resources within the VPC can communicate with each other. 
But by default, there’s no communication between the VPC and the internet outside unless you allow for this communication to happen by properly configuring the VPC. 
Now inside your VPC, you may need some resources to be public and some others to be private. How can you do that? This is the role of subnets that you can create within your VPC. 
Subnets provide you with more detailed control over access to your resources. You can create a **public subnet** if you want to allow for outside traffic to access your resources, 
and you can create a **private subnet** if you don’t want to allow for outside traffic to access your resources.

<div id='2'/>

## 2 - Getting the Address of the Web Application

The architecture of the web application is implemented and provided to you in this lab. Your first task is to get the address of your web application. To do so, you need to find the ALB, since it serves as the single point of contact for clients.

<span style="font-size:16px"><b>2.1.</b></span> To access the AWS console, run the following command in the terminal.
If necessary, open a new terminal by selecting Terminal > New Terminal from the menu.

```bash
cat ../.aws/aws_console_url
```
Open the link in the new browser window.

*Note*: For security reasons, the URL to access the AWS console will expire every 15 minutes, 
but any AWS resources you created will remain available for the 2 hour period. 
If you need to access the console after 15 minutes, please rerun the command to obtain a new active link.

*Note:* If you see the window like in the following printscreen, click on **logout** link, 
close the window and click on console link again.

![AWSLogout](images/AWSLogout.png)

<span style="font-size:16px"><b>2.2.</b></span> To find the Application Load Balancer (ALB) that has been created as part of your application architecture, go to the AWS console and search for **EC2**.
   
![image alt ><](./images/EC2.png)
   
<span style="font-size:16px"><b>2.3.</b></span> In the left panel click on **Load Balancers** (bottom of the panel) 

![image alt ><](./images/LoadBalancers.png)

<span style="font-size:16px"><b>2.4.</b></span> You will see a load balancer called `de-c1w3-alb`. Copy the `DNS Name` field. DNS stands for Domain Name System which translates domain name like example.com into an IP address 
(you can read more about DNS [here](https://aws.amazon.com/route53/what-is-dns/)).

![image alt ><](./images/LoadBalancerDNS.png)

<span style="font-size:16px"><b>2.5.</b></span> Open a new browser window and paste the DNS Name. You will see the following message displayed on the web page.

*Note*: After copying the DNS name in step 2.4 and pasting it into a new browser tab, you may encounter a "This site can't be reached" error.
Check if the browser is attempting to use the HTTPS protocol (`https://`). If it is, manually change the URL to use the HTTP protocol instead (`http://`).

![image alt ><](./images/DashboardOriginal.png)

The web page should display a dashboard for clients, but for brevity and simplicity's sake, you are shown a simple message. Don't worry about the details of this message, 
you will explore them in a later section of this lab. By having opened the webpage, you sent an HTTP request to the ALB. The HTTP request reached the ALB through port 80, 
which is the [default port](https://www.techopedia.com/definition/15709/port-80#:~:text=To%20make%20it%20convenient%20for,Port%2080%20should%20be%20used) for HTTP requests 
(if you don’t know what port means, check [here](https://www.cloudflare.com/learning/network-layer/what-is-a-computer-port/)).

In the next sections, you will learn how to monitor the computing and networking activity of your web app and you will ensure that the principles of “good” data architecture are in place. 
In particular, you will configure your architecture to embrace the following principles: “Prioritize security”, “Plan for failure” , and “Architect for scalability”.

<div id='3'/>

## 3 - Monitoring CPU Usage and Networking Activity

When you share your web app with your clients, you should expect some incoming traffic to your application that needs to be processed. To ensure that your application 
can support the incoming demands, you would need to monitor the usage of computing resources of your web-app. To do so, you can use Amazon CloudWatch, which is the monitoring 
and observability service in AWS that enables you to collect and track computing and memory metrics for your web app.

Monitoring the usage of computing resources of your web-app is one of the practices of the undercurrent DataOps and the Operational Excellence pillar of 
[AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc&wa-guidance-whitepapers.sort-by=item.additionalFields.sortDate&wa-guidance-whitepapers.sort-order=desc). 
These practices emphasize the importance of integrating automation, monitoring of systems, and adaptability into the design of cloud workloads. These practices enable your understanding 
of your workloads and their anticipated behaviors.

In this section, you are going to perform some stress tests to simulate traffic to your website and then monitor CPU usage and networking activity using Amazon CloudWatch.


<span style="font-size:16px"><b>3.1.</b></span> To perform stress tests over your current architecture, you will use an open-source benchmarking tool called [Apache Benchmark](https://httpd.apache.org/docs/2.4/programs/ab.html). 
This tool is used to test the ability of a website to handle a large number of HTTP requests at the same time.
   
In the AWS console, search for the **CloudShell** service:

![image alt ><](./images/CloudShell.png)
    
AWS CloudShell is a browser-based shell that makes it easier to securely manage, explore, and interact with your AWS resources.
    
<span style="font-size:16px"><b>3.2.</b></span> Install the Apache Benchmark tool with the terminal command (the option `-y` allows to automatically confirm the package installation without manual intervention):

```bash
sudo yum install httpd-tools -y
```

<span style="font-size:16px"><b>3.3.</b></span> To generate a stress test over your server you will need to make multiple HTTP GET requests with some concurrency meaning, the requests run at the same time. 
This can be done with the `ab` command of Apache Benchmark. 
Run the following command, replacing `ALB-DNS` with the `DNS Name` of your ALB (you can find it in the address of the browser window where you saw the dashboard representation, just don't copy the `http://` part.).

```bash
ab -n 7000 -c 50 http://<ALB-DNS>/
```

Make sure you add the `/` path at the end of it. The options used in the command are used for the following purposes:
    
- Option `-n` corresponds to the total number of requests that will be sent to the HTTP server.
- Option `-c` corresponds to the number of concurrent (simultaneous) requests that will be done.

<span style="font-size:16px"><b>3.4.</b></span> To monitor the CPU and networking usage, go to the **Auto Scaling Groups** in the AWS console (it is a part of the EC2 section):

![image alt ><](./images/AutoScalingGroups.png)

<span style="font-size:16px"><b>3.5.</b></span> Select the Auto Scaling group created for you and select the **Monitoring** tab and then click on **EC2**:

![image alt ><](./images/Monitoring.png)

There you can see some of the available metrics that are measured which include CPU, Networking (inbound and outbound), among others. 
During the test, you can check the CPU and Networking graphs to see an increase in the metrics; the graph updates can take some time as metrics in AWS CloudWatch have a 5-10 minute latency. 
You will need to click on ![](./images/Refresh.png) button to see the updates.
There are other available metrics and the possibility of defining new ones through AWS CloudWatch.

AWS CloudWatch is the monitoring and observability service in AWS that enables users to collect and track metrics, collect and monitor log files, and set alarms. 
It is designed to provide a comprehensive view of the AWS resources, applications, and services running in the AWS infrastructure.

After all requests are performed, you should notice a reduction in the CPU activity as well as in the networking.

<div id='4'/>

## 4 - Enhancing Security

Now that you know how to monitor the computing resources of your application, it’s time for you to delve into the security aspect of your servers. Security should always be your priority as stated 
in the principle “prioritize security”. Also, the security pillar provides insights into how to leverage cloud technologies to secure data, systems, and assets, and to protect them from unauthorized access.

You were told that through port 90 of the ALB some private data is displayed, but only certain people inside your company should have access to it. In this section, you will fix this issue so that any inbound 
traffic is only allowed to go through port 80. In particular, you will work with adjusting the **security groups** of the ALB, which is a tool that acts as a virtual firewall, controlling inbound and outbound 
traffic through the ALB.

<span style="font-size:16px"><b>4.1.</b></span> Take the `DNS Name` of your ALB and paste it into your browser search bar pointing to the port 90, as follows:

```
<ALB-DNS>:90
```

Through this port, you see a message that mimics the display of some private data. You are surprised given the security requirements that should have been implemented, 
so you decide to fix it now. 
    
<span style="font-size:16px"><b>4.2.</b></span> In the AWS console, again you search for **EC2** and then click on **Security Groups** in the left panel. 

![image alt ><](./images/SecurityGroups.png)

You will see a list of security groups, out of which you will work with the following ones: 
- `de-c1w3-ec2-sg`: This is the security group of your EC2 instances (servers).
- `de-c1w3-alb-sg`: This is the security group of the Load Balancer.

<span style="font-size:16px"><b>4.3.</b></span> Click on the id for the security group with the name `de-c1w3-ec2-sg`. In the **Inbound Rules** section, you will find the following rule:

- Rule with `Type: All TCP`, `Port range: 0-65535` and as source a security group id. This source is the security group of the ALB. The purpose of this security group is to ensure that servers will only receive traffic from the ALB.

<span style="font-size:16px"><b>4.4.</b></span> Go back and click on the ID for the `de-c1w3-alb-sg` security group. Check the **Inbound Rules** to find the following rule:

- Rule with `Type: All TCP`, `Port range: 0-65535` and `Source: 0.0.0.0/0` (which means all IP addresses). This rule means that any source can access the ALB using any port, which is quite open and insecure!

<span style="font-size:16px"><b>4.5.</b></span> Now, click on **Edit inbound rules** and add a new rule with the following properties: 

- `Port range: 80` 
- `Source: 0.0.0.0/0`

![image alt ><](./images/SecurityGroupRule.png)

Now delete the old rule and save changes.

So now although all the internet can have access to your ALB, the traffic is only allowed through port 80, so if you go back to your browser and point to port 90 (`<ALB-DNS>:90`) 
you should not have access to it. 
    
*Note*: You may still see a display of the website previously accessed through port 90 and stored in a cache. But if you refresh the webpage, it will not load.
    
To check if the rule was properly created, in your browser, point to port 80 (by default you can only put `<ALB-DNS>` on your browser search bar) 
and see if you can see the Dashboard message.

By configuring security groups, you restricted access to sensitive data presented on port 90 of the ALB to authorized personnel within the company. This was done to improve the system's overall security, 
following the guidelines of the AWS Well-Architected Framework's Security pillar and the principle of “Prioritize security”.

<div id='5'/>

## 5 - Checking EC2 Availability

If you check the given architecture of the web application, you notice that each EC2 instance belongs to a different **Availability Zone (AZ)**. Availability Zones are isolated data centers, each with 
independent power, cooling, and networking infrastructure. Designing applications to span multiple AZs enhances their fault tolerance and resilience, and provides a foundation for highly available systems. 
This cloud practice is related to the reliability pillar of cloud-based solutions, as well as to the principle of “Plan for failure”.


<span style="font-size:16px"><b>5.1.</b></span> For reliability, you can again put the `DNS Name` in your browser. But now, take a closer look at the message:

```
Dashboard data served from host <host-internal-ip>.ec2.internal in <AZ> availability zone
```

You will see an internal IP from one of the servers of the ALB and an availability zone. Refresh the page and you will see that both, the internal IP and the availability zone values change. 
That means that the data was served every time from different availability zones and internal IP. Imagine, that if something goes wrong with one of the AZ, your data still can be served 
from another one!

Multi-AZ deployments in AWS offer businesses a robust solution to mitigate the impact of potential failures. By distributing application components across different AZs, 
organizations can achieve high availability and fault tolerance. In the event of an outage or disruption in one AZ, traffic is automatically routed to healthy instances 
in other AZs, ensuring uninterrupted service delivery. This architectural approach minimizes downtime, enhances performance, and contributes to a seamless user experience.

While Multi-AZ deployments enhance reliability within a single AWS region, adopting a multi-region strategy takes resilience to the next level. Multi-region deployments 
involve replicating applications and data across different geographic locations, offering protection against regional disasters, geopolitical issues, or infrastructure 
failures. This approach ensures business continuity on a broader scale and caters to global users, providing low-latency access to services.

<div id='6'/>

## 6 - Performing Auto Scaling

You need to make sure you’re using the right resources efficiently and that you’re embracing 
the principle of “Architect for scalability” by scaling up and down with the demand.

<div id='6-1'/>

### 6.1 - Using Resources Efficiently

The current instances are of type `t3.micro`  (*t* is the family of the instance, *3* is the generation and micro represents the size of the EC2 instance). 
You noticed that those instances can be a bit overpowered for your infrastructure, so after reading a bit more about the 
[instance types](https://aws.amazon.com/ec2/instance-types/t3/) you decided to scale them down (reduce the size) and use a more suitable `t3.nano` instance.
To scale the instances, you need to modify the way they are created inside the **Auto Scaling Group**, which can be done through the **Launch templates**. 

<span style="font-size:16px"><b>6.1.1.</b></span> In the AWS console, search for **EC2** service and find the **Auto Scaling Groups** section in the left panel. Select the Auto Scaling group provided to you. 


<span style="font-size:16px"><b>6.1.2.</b></span> In the **Details** tab find the **Launch template** section and click on **Edit**. 

![image alt ><](./images/LaunchTemplateEdit.png)

<span style="font-size:16px"><b>6.1.3.</b></span> Find a **Version** dropdown and below a link to `Create a new launch template version` (below it). This will open a page to create a new version of the template. 

![image alt ><](./images/CreateLaunchTemplateVersion.png)

<span style="font-size:16px"><b>6.1.4.</b></span> Make sure that the checkbox **Provide guidance to help me set up a template that I can use with EC2 Auto Scaling** is **unchecked**: 

![image alt ><](./images/TemplateCheckbox.png)

In the **Instance type** section choose the `t3.nano` instance type:

![image alt ><](./images/InstanceType.png)

Scroll down until you find the **Network Settings**. In subnet, click on the drop-down menu and select `Don't include in launch template`.

![image alt ><](./images/AutoscalingSubnet.png)
    
Then, click on ![](./images/CreateTemplateVersion.png).

<span style="font-size:16px"><b>6.1.5.</b></span> Go back to your Auto Scaling group and then to **Details** > **Launch template** > **Edit**. In the **Version** drop-down, now you can select the `Latest` option and click on ![](./images/Update.png) button at the bottom of the page. 
    
*Note*: If you are not able to use the new template and have received this error

![image alt ><](./images/TemplateError.png)

it could be because you did not choose the right EC2 instance (`t3.nano`) in step 6.1.4. 
In this case, please repeat steps 6.1.3-6.1.4 and choose `t3.nano`. 
The number should be `3` and the size should be `nano`.

<span style="font-size:16px"><b>6.1.6.</b></span> Now, you need to terminate the instances so the new instances that will be launched will be of the instance type just defined. In the **EC2** service, go to **Instances** and select the two that are currently running under the name of `de-c1w3-asg`. Right-click on any of them and click on **Terminate instance** (or **Terminate (delete) instance**). You may need to confirm this action in the pop-up window.
    
![image alt ><](./images/TerminateInstance.png)
    
Given that the Auto Scaling group has a desired capacity of 2 instances, after some minutes the new instances (with the `t3.nano` instance type) 
should start running again. Refresh the UI every minute until it appears as running. Before moving to the next section of the lab, wait until the newly created instances have instance state `Running`.
    
<div id='6-2'/>

### 6.2 - Performing Auto Scaling

<span style="font-size:16px"><b>6.2.1.</b></span> The EC2 instances in your Auto Scaling group can increase or decrease in number depending on the demand. With Auto Scaling group, you only pay for what you use. When demand decreases, AWS Auto Scaling will 
automatically remove any extra EC2 so you avoid overspending.
    
Currently, Auto Scaling is not enabled, so the Auto Scaling group will not be able to scale up or down. To enable Auto Scaling, you will need to create a scaling policy where you need to specify metrics and 
threshold values that invoke the scaling process.
    
In the AWS console, go back to **Auto Scaling Groups** section under the **EC2** service, choose your Auto Scaling group and click on the **Automatic scaling** tab. 
    
<span style="font-size:16px"><b>6.2.2.</b></span> Under **Dynamic scaling policies** section, click on **Create dynamic scaling policy**.
    
![image alt ><](./images/DynamicScalingPolicy.png)

<span style="font-size:16px"><b>6.2.3.</b></span> Create a new policy with the following properties:

- Policy type: `Target tracking scaling`
- Scaling policy name: `de-c1w3-scaling-policy`
- Metric type: `Application Load Balancer request count per target`
- Target group: `de-c1w3-ec2-tg-port80`
- Target value: `60`
- Instance warmup: `60` seconds

Click on **Create** button.

The meaning of those values are:
- As the Metric type is a request count per target, with a target value of 60, it means that when the HTTP (port 80) request count goes above 60 
(value chosen just for the sake of simplicity in this lab), the Auto Scaling group may scale out to add more instances to handle the increased load. 
If the request count per target drops below 60, the Auto Scaling group will scale in by reducing the number of instances to save costs and maintain efficiency.
    
- A warm-up time refers to a period during which newly launched instances are allowed to receive traffic and fully initialize before being considered in-service 
for the Auto Scaling evaluation metrics. During the warm-up time, the Auto Scaling group monitors the health and status of the instances to ensure 
they are ready to handle the production workload. For the sake of simplicity in this lab, you set this value to 60 seconds, but the AWS default is 300 seconds (5 minutes).

<span style="font-size:16px"><b>6.2.4.</b></span> Perform a more intense test with Apache Benchmark to test the scaling policy that was created. Go to **CloudShell** and run the following command
(replace `ALB-DNS` with the `DNS Name` of your ALB):

```
ab -n 1000000 -c 200 http://<ALB-DNS>/
```

This test should run for some minutes, in the meantime, you can monitor your instances. 
Go back to the **Auto Scaling Groups** service in the AWS console and click on **Monitoring** and then on **EC2** to watch the CPU and Network metrics again. 
After some time (about 5 min) when those metrics start increasing, you can switch to the **Activity** tab and you will see some notifications regarding additional instances 
being launched to handle the traffic through the 80 port. 
    
After the stress test finishes, you can continue monitoring the metrics and the **Activity** tab to see when the metrics go down again and even the launched instances are terminated. 
Take into account that there is some delay in the metrics plots in the **Monitoring** tab after you start the test. You can re-run the command for the test if you want to maintain the stress for more time.

Congratulations on finishing this lab! You are now ready to submit your work by clicking on **Submit assignment** (top right corner).