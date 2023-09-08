
## List Processes
This is a simple single node jobs that lists the processes running on a machine and uploads it.
The intent of this job is to demonstrate that jobs function as expected and the enviornment is configured properly.


## Summary
* This is an example action that runs on a single node (Node1).   
* The job uses a single compount action
* The job schedule is: immediate
* Action 1:
    * Intpreter OS command
    * Action:
        ```
        ps > process.txt
        aws s3 cp process.txt s3://demo-artifacts-8349
        rm process.txt
        commit | true
        ````  

## Steps
1) delete file from the S3 Bucket
```
aws s3 rm s3://demo-artifacts-8349/process.txt
```
2) show the S3 bucket does not contain the process file
```
aws s3 ls s3://demo-artifacts-8349/ --human-readable --summarize
```
3) run the job
```
courier scheduler create-job ~/demos/list-processes/job.json
```
4) check the job status (using ID form last ste)
```
courier state list-job-instances <<JOBID>>
```
5) check S3
```
aws s3 ls s3://demo-artifacts-8349/ --human-readable --summarize
```
6) Download the file
```
aws s3 cp s3://demo-artifacts-8349/process.txt .
```
6) View the file
```
cat process.txt 
```
7) Delete the local file
```
rm process.txt 
```
8) Delete the file from S3
```
aws s3 rm s3://demo-artifacts-8349/process.txt
```

### NOTES
* The node targeted is ~/nodes/node-1.ssh
