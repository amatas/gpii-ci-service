# GPII Continuous Integration Service

The [GPII Continuous Integration server](https://ci.gpii.net/) uses [Jenkins Job Builder](http://docs.openstack.org/infra/jenkins-job-builder) definitions located in the ``jenkins_jobs`` directory of this repository to generate its configuration. This allows CI server jobs to be maintained transparently using version control instead of having to rely on the Jenkins UI. 

The CI server is deployed on a CentOS VM. It delegates the majority of job tasks to physical hosts so that job performance issues don't affect the Jenkins process and also because certain jobs require VMs that can provide windowing environments. One exception is the ``update-jenkins-job-definitions`` job which runs on the CI server itself. This job should not be removed.

For security reasons an Nginx host sits in front of the CI server and creates a read-only archive of its UI. The contents of this archive are served when the https://ci.gpii.net URL is visited. The CI server itself can only be reached by a limited number of hosts.

The remaining definitions in the ``jenkins_jobs`` directory are what the GPII build jobs use:

* ``defaults.yml`` - default values used by multiple jobs
* ``linux.yml`` - job definition for the [GPII Linux Personalization Framework](https://github.com/gpii/linux)
* ``universal.yml`` - job defintion for the [GPII Universal](https://github.com/gpii/universal/) project
* ``windows.yml`` - job defintion for the [GPII Windows Framework](https://github.com/gpii/windows/) project

## Triggering CI Jobs

Pull requests sent by user accounts whitelisted in the [macros.yml](https://github.com/GPII/ci-service/blob/master/jenkins_jobs/macros.yml) file will trigger builds in the CI environment using the [GitHub Pull Request Builder plugin](http://docs.openstack.org/infra/jenkins-job-builder/triggers.html#triggers.github-pull-request). The CI server checks for PR changes every five minutes.

### How to Avoid Triggering a Job

If you would like to avoid triggering a job please include the following text in your PR comment:

```
[skip ci]
```

### How to Manually Trigger a Job

If an unrecognized account is used to send a PR then the CI server will post a comment for that PR asking an administrator to verify changes and trigger the job. An administrator can trigger jobs by posting the following comment:

```
ok to test
```

A list of administrators named ``admin-list`` is maintained in the [macros.yml](https://github.com/GPII/ci-service/blob/master/jenkins_jobs/macros.yml) file. 

### GitHub Account Used by CI Server

The CI server uses the [gpii-bot](https://github.com/gpii-bot) account to post PR comments. It has to be added as a collaborator to every repository that needs to be integrated with the CI service.