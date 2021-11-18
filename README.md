# Cyber-Security
Files for Cyber Security Boot Camp
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Project 1 Diagram](Images/Project 1 Diagram)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: redadmin
  become: true
  tasks:
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    - name: Install Docker module
      pip:
        name: docker
        state: present

    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: 262144
        state: present
        reload: yes

    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly protected, in addition to restricting access to the network.
- Load balancing protects against Ddos attacks.
- An advantage to having a jump box is that it is a secure computer that allows admins to connect to it before launching into any tasks or unprotected enviorments. It provides extra layers of security and controls access.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filbeat monitors and collects log files in specified locations.
- Metricbeat records the metrics and statistics of specified files.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux            |
| Web1     | VM       | 10.0.0.5   | Linux            |
| Web2     | VM       | 10.0.0.7   | Linux            |
| Elk-Vm   | Elkserver| 10.1.0.5   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Elk Server machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Workstation: 76.30.121.237

Machines within the network can only be accessed by Jump Box machine.
- Jump Box: 20.120.100.250

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No                  | 76.30.121.237        |
| Web1     | No                  | 20.120.100.250       |
| Web2     | No                  | 20.120.100.25        |
| Elkserver| No                  | 20.120.100.25 / 26.30.121.237 |
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- It is simple to learn and playbooks are written with YAML and it has no dependency on other agents.

The playbook implements the following tasks:
- Specifies the elk group to install the playbook on.
- Increase system memory.
- Installs docker, docker.io and python3-pip.
- Makes the container accessible though certain ports.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

~/Project_1/README/Images/docker_ps_screenshot.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web1: 10.0.0.5
- Web2: 10.0.0.7

We have installed the following Beats on these machines:
Metricbeat
Filebeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects and monitors log files and it will forward them to elasticsearch for indexing.
- Metricbeat collects statistics and metrics for systems and platfroms such as apache.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the configuration file to ~/etc/ansible directory.
- Update the configuration file to include the group and IP of the VM that you wish to run the playbook on.
- Run the playbook, and navigate to kibana to check that the installation worked as expected.

- ![Metricbeat Playbook](Ansible/metricbeat-playbook.yml)
- ![Filebeat Playbook](Ansbile/filebeat-playbook.yml)
- You would copy both of them into the ansible container.
- You would need to update the configuration file, to specify the machine you need to update the IPs for the desired VM, you could also set groups if you wish to group certain VMs together.
- Which URL do you navigate to in order to check that the ELK server is running? The URL that you need to navigate to in order to check if your ELK server is running is the following: http://[ELK-VM.External.IP]:5601/app/kibana

-To run a playbook use the command: ansible-playbook >playbookname<
