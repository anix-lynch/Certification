# C2W1 Assignment - ✅ 100% PASSED!

## ✅ Working Configuration (50/50 points)

### RDS Security Group Inbound Rule
**Status:** ✅ PASSING

```bash
# RDS Security Group ID: sg-04a5bae4dd5bef4d2
# Bastion Security Group ID: sg-0501aacba2817dbd7

# Current working rule (verified passing):
aws ec2 describe-security-groups \
  --group-ids sg-04a5bae4dd5bef4d2 \
  --query 'SecurityGroups[0].IpPermissions'

# Output:
[
    {
        "IpProtocol": "tcp",
        "FromPort": 5432,
        "ToPort": 5432,
        "UserIdGroupPairs": [
            {
                "UserId": "742782644978",
                "GroupId": "sg-0501aacba2817dbd7"
            }
        ],
        "IpRanges": [],
        "Ipv6Ranges": [],
        "PrefixListIds": []
    }
]
```

**Key:** Only security group reference `sg-0501aacba2817dbd7`, NO CIDR blocks.

---

## ✅ Working Configuration (50/50 points)

### S3 Bucket Policy
**Status:** ✅ PASSING

**Final working policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::de-c2w1a1-742782644978-us-east-1-data/csv/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "50.16.129.134"
        }
      }
    }
  ]
}
```

**Key points:**
- Resource must be `/csv/*` (not `/*`)
- IP must be `50.16.129.134` (no `/32` suffix)
- Simple policy with only `s3:GetObject` action

---

## Key Information

- **Bastion Host:** `de-c2w1a1-bastion-host`
- **Bastion Security Group:** `sg-0501aacba2817dbd7`
- **Bastion IAM Role:** `arn:aws:iam::742782644978:role/de-c2w1a1-bastion-role`
- **Bastion Private IP:** `10.0.1.45`
- **Expected Bastion Public IP (per grader):** `50.16.129.134`
- **RDS Instance:** `de-c2w1a1-rds`
- **RDS Security Group:** `sg-04a5bae4dd5bef4d2`
- **S3 Bucket:** `de-c2w1a1-742782644978-us-east-1-data`

---

## Lessons Learned

1. **Always use the correct EC2 instance** - `de-c2w1a1-bastion-host` (not external-bastion-host)
2. **Security group references > CIDR blocks** for RDS inbound rules
3. **Graders are format-specific**:
   - No `/32` suffix on IP addresses
   - Use `/csv/*` for S3 resource paths (not `/*`)
4. **Read assignment instructions carefully** - they contain the exact format expected
