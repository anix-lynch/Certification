# Week 1: Troubleshooting Database Connectivity on AWS

**Status**: 🚧 **Ready to Start**  
**Assignment**: C2_W1 - Troubleshooting Database Connectivity on AWS  
**Assignment Type**: AWS Networking & Database Troubleshooting  
**Estimated Time**: 2-3 hours

---

## 📋 Assignment Overview

**Objective**: Troubleshoot and resolve common issues when connecting to AWS RDS databases from EC2 instances.

This is a hands-on AWS troubleshooting lab focusing on:
- VPC and networking configuration
- Security group rules
- Database connectivity
- IAM permissions
- SQL operations

**Note**: This is NOT a coding assignment - it's about AWS configuration and troubleshooting!

---

## 🎯 Learning Objectives

By completing this assignment, you will learn:

1. **AWS Networking**
   - VPC (Virtual Private Cloud) configuration
   - Subnet configuration
   - Security group management
   - Network troubleshooting

2. **Database Connectivity**
   - RDS instance configuration
   - PostgreSQL connection setup
   - psql client usage
   - Connection troubleshooting

3. **AWS Security**
   - Security group inbound/outbound rules
   - IAM roles and permissions
   - Database authentication

4. **Problem-Solving Skills**
   - Systematic troubleshooting approach
   - Reading AWS console logs
   - Identifying network issues
   - Testing connectivity

---

## 📁 Assignment Structure

### Part 1: Fixing Database Connectivity Issues
- Connect EC2 instance to RDS database
- Troubleshoot VPC configuration
- Fix security group rules
- Establish database connection

### Part 2: Fixing Permission Issues
- Resolve IAM permission errors
- Configure proper access policies
- Test database operations

---

## 🛠️ Technologies & Services

### AWS Services:
- **EC2** - Virtual server instances
- **RDS** - PostgreSQL database
- **VPC** - Virtual network
- **Security Groups** - Firewall rules
- **IAM** - Access management
- **Systems Manager** (optional)

### Tools:
- **psql** - PostgreSQL command-line client
- **AWS CLI** - Command-line interface
- **SQL** - Database queries

---

## 🚀 Getting Started

### Prerequisites:
- AWS Console access (provided by Coursera)
- Basic understanding of networking concepts
- Familiarity with SQL
- Understanding of cloud security principles

### Steps Overview:

1. **Access AWS Console**
   ```bash
   cat ../.aws/aws_console_url
   ```

2. **Identify the Issue**
   - Check RDS instance details
   - Review EC2 instance configuration
   - Examine VPC settings
   - Inspect security groups

3. **Fix Connectivity**
   - Modify security group rules
   - Update VPC configuration
   - Test connection with psql

4. **Verify Access**
   - Run test SQL queries
   - Confirm data operations
   - Document the solution

---

## 📝 Key Concepts

### VPC (Virtual Private Cloud)
- Private network in AWS
- Controls network access to resources
- Subnets, route tables, gateways

### Security Groups
- Virtual firewall for instances
- Control inbound/outbound traffic
- Rules based on protocols, ports, IP addresses

### RDS (Relational Database Service)
- Managed database service
- PostgreSQL instance in this lab
- Endpoint and port configuration

---

## 🔍 Troubleshooting Checklist

When facing connectivity issues, check:

- [ ] EC2 and RDS in same VPC?
- [ ] Security group allows port 5432?
- [ ] Inbound rules configured correctly?
- [ ] Database endpoint correct?
- [ ] Credentials valid?
- [ ] psql client installed?
- [ ] Network ACLs not blocking?

---

## 📊 Expected Outcomes

After completing this assignment:

✅ Understand AWS networking fundamentals  
✅ Know how to troubleshoot database connectivity  
✅ Configure security groups properly  
✅ Connect EC2 to RDS successfully  
✅ Execute SQL operations on cloud databases  

---

## 📚 Resources

### AWS Documentation:
- [Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/)
- [Amazon RDS User Guide](https://docs.aws.amazon.com/rds/)
- [Security Groups for EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html)

### PostgreSQL:
- [psql Documentation](https://www.postgresql.org/docs/current/app-psql.html)
- [PostgreSQL Tutorials](https://www.postgresql.org/docs/current/tutorial.html)

---

## 💡 Tips

1. **Read Error Messages Carefully** - They often tell you exactly what's wrong
2. **Check Security Groups First** - Most common connectivity issue
3. **Verify VPC Configuration** - EC2 and RDS must be able to communicate
4. **Test Step by Step** - Isolate the problem systematically
5. **Document Your Changes** - Note what you modified and why

---

## ⚠️ Common Issues

| Problem | Likely Cause | Solution |
|---------|--------------|----------|
| Connection timeout | Security group blocking | Add inbound rule for port 5432 |
| Wrong VPC | EC2/RDS in different VPCs | Move to same VPC or configure peering |
| Authentication failed | Wrong credentials | Verify username/password |
| Permission denied | IAM policy issue | Update IAM role/policy |

---

## 🎓 Skills Gained

- AWS networking troubleshooting
- Security group configuration
- Database connectivity setup
- Cloud infrastructure debugging
- PostgreSQL operations
- Problem-solving methodology

---

## 📝 Notes

- This assignment is **configuration-focused**, not code-focused
- Changes are made in AWS Console (GUI)
- Some AWS CLI commands may be used
- SQL queries will be executed but not developed
- Focus is on **understanding AWS networking**

---

## 🔄 Status

**Current Status**: Ready to start  
**Next Steps**: 
1. Download files from Coursera
2. Follow assignment instructions
3. Document your troubleshooting process
4. Complete both parts of the assignment

---

**Last Updated**: December 13, 2025  
**Difficulty**: Intermediate  
**Time Commitment**: 2-3 hours
