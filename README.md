# GPII Continuous Integration Service

The [GPII Continuous Integration server](https://ci.gpii.net/) uses [Jenkins Job Builder](http://docs.openstack.org/infra/jenkins-job-builder) definitions located in the ``jenkins_jobs`` directory of this repository to generate its configuration. This allows CI server jobs to be maintained transparently using version control instead of having to rely on the Jenkins UI. 

The CI server is deployed on a CentOS VM. It delegates the majority of job tasks to physical Linux hosts so that job performance issues don't affect the Jenkins process and also because certain jobs require VMs that can provide windowing envrionments. Two exceptions are the ``update-jenkins-interface`` and ``update-jenkins-job-definitions`` jobs which run on the CI server itself. These jobs should not be removed.

For security reasons an Nginx host sits in front of the CI server and creates a read-only archive of its UI using the ``update-jenkins-interface`` job. The contents of this archive are served when the https://ci.gpii.net URL is visited. The CI server itself can only be reached by a limited number of hosts.

The remaining definitions in the ``jenkins_jobs`` directory are what the GPII build jobs use.

* ``defaults.yml`` - default values used by multiple jobs
* ``linux.yml`` - job definition for the [GPII Linux Personalization Framework](https://github.com/gpii/linux)
* ``universal.yml`` - job defintion for the [GPII Universal](https://github.com/gpii/universal/) project

Commits in the GPII project repositories listed above will trigger builds in the CI environment using GitHub webhooks.
