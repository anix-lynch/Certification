# Week 3 Assignment Summary - Good Data Architecture

## What You Completed

### Section 2: Getting ALB DNS Name
- Found Application Load Balancer `de-c1w3-alb` in AWS EC2 console
- Retrieved DNS name: `de-c1w3-alb-327022008.us-east-1.elb.amazonaws.com`
- Verified web application accessible via HTTP (port 80)

### Section 3: Monitoring CPU Usage and Networking Activity
- Installed Apache Benchmark (`httpd-tools`) in AWS CloudShell
- Ran stress test: `ab -n 7000 -c 50 http://ALB-DNS/`
- Monitored CPU and network metrics in CloudWatch via Auto Scaling Groups
- Observed resource usage spikes during stress test

### Section 4: Enhancing Security
- **Problem:** Port 90 exposed private data (security vulnerability)
- **Solution:** Modified ALB security group (`de-c1w3-alb-sg`)
  - Added rule: Allow port 80 from `0.0.0.0/0`
  - Removed rule: Blocked "All TCP" (0-65535) rule
- **Result:** Only port 80 accessible, port 90 blocked

### Section 5: Checking EC2 Availability
- Verified multi-AZ deployment
- Refreshed dashboard page multiple times
- Observed traffic distributed across different availability zones (us-east-1a, us-east-1b)
- Confirmed high availability and fault tolerance

### Section 6.1: Using Resources Efficiently
- Changed instance type from `t3.micro` → `t3.nano`
- Created new launch template version (Version 2) with `t3.nano`
- Updated Auto Scaling Group to use latest template version
- Terminated old `t3.micro` instances
- New `t3.nano` instances launched automatically

### Section 6.2: Performing Auto Scaling
- Created dynamic scaling policy: `de-c1w3-scaling-policy`
  - Policy type: Target tracking scaling
  - Metric: Application Load Balancer request count per target
  - Target group: `de-c1w3-ec2-tg-port80`
  - Target value: 60 requests per target
  - Instance warmup: 60 seconds
- Ran final stress test: `ab -n 1000000 -c 200 http://ALB-DNS/`
- Verified auto-scaling working:
  - Instances scaled UP during high load
  - Instances scaled DOWN after load decreased

## Key AWS Services Used
- **EC2**: Virtual servers (instances)
- **Application Load Balancer (ALB)**: Distributes traffic across instances
- **Auto Scaling Groups**: Automatically adjusts instance count based on demand
- **CloudWatch**: Monitoring and metrics
- **Security Groups**: Virtual firewall rules
- **Launch Templates**: Instance configuration templates
- **VPC/Subnets**: Network isolation and organization

## Architecture Principles Applied
- ✅ **Prioritize Security**: Blocked unauthorized port access
- ✅ **Plan for Failure**: Multi-AZ deployment for high availability
- ✅ **Architect for Scalability**: Auto-scaling based on demand
- ✅ **Operational Excellence**: Monitoring with CloudWatch

## Result
**Assignment passed!** All sections completed successfully.

