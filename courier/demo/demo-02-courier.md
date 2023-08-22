# 1/ Reoccuring Jobs
* Show a single re-occurring job template
* Schedule the the job
chef courier scheduler create-job jobs/rrule.json
* Show the schedule estimation
chef courier scheduler estimate-schedule <ID>
chef courier scheduler get-job <ID> --json | jq '.NextExecutionTime'
* Open the agent monitor to see the jobs running

# 2/ Scheduler-Next-Available
* Show a next available job template
* Schedule the the job
* Open the agent monitor to see the jobs running

# 3/ Direct Delivery of a Job

