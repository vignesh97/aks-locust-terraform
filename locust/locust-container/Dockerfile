
FROM python:2.7.8

MAINTAINER Vigneshwaran Ravimurugan <vigneshwar.ravimurugan@gmail.com>

# Add the licenses for third party software and libraries
ADD licenses /licenses

# Add the external tasks directory into /tasks
ADD locust-tasks /locust-tasks

# Install the required dependencies via pip
RUN pip install -r /locust-tasks/requirements.txt

# Expose the required Locust ports
EXPOSE 5557 5558 8089

# Set script to be executable
RUN chmod 755 /locust-tasks/run.sh

# Start Locust using LOCUS_OPTS environment variable
ENTRYPOINT ["/locust-tasks/run.sh"] 
