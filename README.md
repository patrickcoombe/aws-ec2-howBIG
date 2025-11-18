# Show How Large My AWS EC2 Server Disks Are

A quick script to run inside AWS CLI  / AWS web shell to list all EC2 instances and see how large your disks are in total.

This script is if for some reason you cannot see the GUI > EC2 > EBS

It basically parses out the "aws ec2 describe-instances" command. 

this script will look in every active region, and search for all instances regardless of type

Here is some sample output:


```bash
patrick $ ./d.sh
Scanning ALL regions for instances and calculating disk sizes...
This might take 10-20 seconds...
Region          Instance ID          Type            State           Disk(GB)  
----------------------------------------------------------------------------------
us-east-1       i-xxxxxxxxxxxxxxxxx  t2.micro        running         40 GB     
us-east-1       i-xxxxxxxxxxxxxxxxx  t2.micro        running         10 GB     
us-east-1       i-xxxxxxxxxxxxxxxxx  t3.small        running         20 GB     
us-east-1       i-xxxxxxxxxxxxxxxxx  c6a.2xlarge     running         160 GB    
us-east-2       i-xxxxxxxxxxxxxxxxx  t3.micro        running         20 GB     
----------------------------------------------------------------------------------
patrick $ 
```
