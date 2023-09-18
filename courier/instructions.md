
# Instructions for user

These are the commands to:
- create a job
- track the status of the job
- get the details of the job
## List all the scheduled jobs
- List the scheduled jobs in the scheduler  
  `$ chef courier scheduler list-jobs`
- Check the existence of a job  
  `$ chef courier scheduler peek-job <job_id>`
## Create a job from a demo file
- Create a job schedule
  `$ chef courier scheduler create-job content/jobs/<file_name>`
## Get details of a job
- Get Details of a job given a job id  
  `$ chef courier scheduler get-job <job_id>`
## Get list of job instances of a  job
- Get List of a job instances for a given job ID  
  `$ chef courier state list-job-instances <job_id>`
### Output
```json  
{  
"id": "<job_instance_id>",  
"job_id": "<job_id>",  
"status": "<status>",  
"abandon_ct": <count_of_abandoned_job_runs>,  
"fail_ct": <count_of_failed_job_runs>,  
"success_ct": <count_of_successful_job_runs>  
}  
```
## Get all the job runs
- Get the list of job runs for a given job instance id (fetch it from the response of last command)  
  `$ chef courier state list-job-instance-runs <job_instance_id>`
### Output
```json  
	{  
	"nodeId": "<node_id>>",  
	"groupNumber": <node_group_number>,  
	"status": "<run_status>",  
	"runId": "<job_run_id>"  
	}  
	.....  
	..... 
```
## Get list of job run steps
- Get list of job run steps of any job run (fetch any job run id from the last command output)  
  `$ chef courier state list-job-run-steps <job_run_id>`
### Output
```json
{
  "steps": [
    {
      "inputs": {},
      "interpreterPath": "<interpreter_path>",
      "interpreterVersion": "",
      "numAttempts": 0,
      "outputs": {},
      "reason": "",
      "run_id": "<job_run_id>",
      "status": "<job_run_status>"
    }
  ]
}
```
## Verify the changes
- Log in to a node where the job is executed
  `$ cd ~/nodes && ./node-<count>.ssh`
  Eg:
  `cd ~/nodes && ./node-1.ssh`
- Check the changes in the node based on the job

## Check the log in the server
- Log in to the courier server node
  `$ cd ~/nodes && ./server.ssh`
- Check the log
  `journalctl -u courier* -f`

## Check the log in the node
- - Log in to a node where the job is executed
    `$ cd ~/nodes && ./node-<count>.ssh`
    Eg:
    `cd ~/nodes && ./node-1.ssh`
- Check the log in a node using `journalctl`
  `$ journalctl -u courier -f`