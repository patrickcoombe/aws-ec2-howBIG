#!/bin/bash

# ran the aws ec2 describe instances command so many times with so many flags I turned it into a shell script lol enjoy 

echo "scanning all regions and instances"
echo "this can take a whie if you have a lot of regions/instances"
printf "%-15s %-20s %-15s %-15s %-10s\n" "Region" "Instance ID" "Type" "State" "Disk(GB)"
echo "----------------------------------------------------------------------------------"

# 1. Get list of all available regions
for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); do

    # 2. Get instances in that region
    # capture the id / type / state
    aws ec2 describe-instances --region "$region" \
      --query "Reservations[*].Instances[*].[InstanceId, InstanceType, State.Name]" \
      --output text | while read -r instance_id instance_type instance_state; do
        
        # If we found an instance, calculate its volume size
        if [ -n "$instance_id" ]; then
            
            # 3. Sum up volume sizes for this specific instance in this specific region
            total_size=$(aws ec2 describe-volumes --region "$region" \
              --filters Name=attachment.instance-id,Values="$instance_id" \
              --query "Volumes[*].Size" \
              --output text | tr '\t' '\n' | awk '{s+=$1} END {print s}')

            # Default to 0 if no volume found
            if [ -z "$total_size" ]; then total_size=0; fi

            # 4. Print the result
            printf "%-15s %-20s %-15s %-15s %-10s\n" "$region" "$instance_id" "$instance_type" "$instance_state" "${total_size} GB"
        fi
    done
done
echo "----------------------------------------------------------------------------------"
