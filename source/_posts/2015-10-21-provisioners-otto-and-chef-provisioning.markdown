---
layout: post
title: "Provisioners: Otto and Chef Provisioning"
date: 2015-10-21 03:30:16 +0000
comments: true
categories: 
---

# Application Provisioning Tools

All performed on OSX.

## HasiCorp Otto

### Installation

* Install Virtualbox
* Download .zip from [downloads](https://ottoproject.io/downloads.html) page for specific platform.
* Unzip and otto binary to PATH

		$ otto
		usage: otto [--version] [--help] <command> [<args>]

		Available commands are:
		    build      Build the deployable artifact for the app
		    compile    Prepares your project for being run.
		    deploy     Deploy the application
		    dev        Start and manage a development environment
		    infra      Builds the infrastructure for the Appfile
		    status     Status of the stages of this application
		    version    Prints the Otto version

### Build project

		$ git clone https://github.com/hashicorp/otto-getting-started.git
		
		$ cd otto-getting-started
		
		$ otto compile
		==> Loading Appfile...
		==> No Appfile found! Detecting project information...
		    No Appfile was found. If there is no Appfile, Otto will do its best
		    to detect the type of application this is and set reasonable defaults.
		    This is a good way to get started with Otto, but over time we recommend
		    writing a real Appfile since this will allow more complex customizations,
		    the ability to reference dependencies, versioning, and more.
		==> Fetching all Appfile dependencies...
		==> Compiling...
		    Application:    otto-getting-started (ruby)
		    Project:        otto-getting-started
		    Infrastructure: aws (simple)

		    Compiling infra...
		    Compiling foundation: consul
		==> Compiling main application...
		==> Compilation success!
		    This means that Otto is now ready to start a development environment,
		    deploy this application, build the supporting infastructure, and
		    more. See the help for more information.

		    Supporting files to enable Otto to manage your application from
		    development to deployment have been placed in the output directory.
		    These files can be manually inspected to determine what Otto will do.
		
		$ otto dev
		Would you like Otto to install Vagrant?
		  An older version of vagrant was found installed (1.7.2). Otto requires
		  version 1.7.4 or higher. Otto can install the latest version of vagrant
		  for you (1.7.4). Would you like Otto to update vagrant for you?

		  Please enter 'yes' to continue. Any other value will exit.

		  Enter a value: yes

		==> Downloading Vagrant v1.7.4...
		    URL: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4.dmg

		    85.3 MB/85.3 MB
		[otto] Attaching Vagrant disk image...
		[otto] Starting Vagrant installer...
		Password:
		installer: Package name is Vagrant
		installer: Upgrading at base path /
		installer: The upgrade was successful.
		[otto] Vagrant installed. Cleaning up...
		==> Vagrant installed successfully!
		==> Creating local development environment with Vagrant if it doesn't exist...
		    Raw Vagrant output will begin streaming in below. Otto does
		    not create this output. It is mirrored directly from Vagrant
		    while the development environment is being created.

		Bringing machine 'default' up with 'virtualbox' provider...
		==> default: Box 'hashicorp/precise64' could not be found. Attempting to find and install...
		    default: Box Provider: virtualbox
		    default: Box Version: >= 0
		==> default: Loading metadata for box 'hashicorp/precise64'
		    default: URL: https://atlas.hashicorp.com/hashicorp/precise64
		==> default: Adding box 'hashicorp/precise64' (v1.1.0) for provider: virtualbox
		    default: Downloading: https://vagrantcloud.com/hashicorp/boxes/precise64/versions/1.1.0/providers/virtualbox.box
		==> default: Successfully added box 'hashicorp/precise64' (v1.1.0) for 'virtualbox'!
		==> default: Importing base box 'hashicorp/precise64'...
		==> default: Matching MAC address for NAT networking...
		==> default: Checking if box 'hashicorp/precise64' is up to date...
		==> default: Setting the name of the VM: dev_default_1444779141710_59790
		==> default: Clearing any previously set network interfaces...
		==> default: Preparing network interfaces based on configuration...
		    default: Adapter 1: nat
		    default: Adapter 2: hostonly
		==> default: Forwarding ports...
		    default: 22 => 2222 (adapter 1)
		==> default: Booting VM...
		==> default: Waiting for machine to boot. This may take a few minutes...
		    default: SSH address: 127.0.0.1:2222
		    default: SSH username: vagrant
		    default: SSH auth method: private key
		    default:
		    default: Vagrant insecure key detected. Vagrant will automatically replace
		    default: this with a newly generated keypair for better security.
		    default:
		    default: Inserting generated public key within guest...
		    default: Removing insecure key from the guest if it's present...
		    default: Key inserted! Disconnecting and reconnecting using new SSH key...
		==> default: Machine booted and ready!
		==> default: Checking for guest additions in VM...
		    default: The guest additions on this VM do not match the installed version of
		    default: VirtualBox! In most cases this is fine, but in rare cases it can
		    default: prevent things such as shared folders from working properly. If you see
		    default: shared folder errors, please make sure the guest additions within the
		    default: virtual machine match the version of VirtualBox you have installed on
		    default: your host and reload your VM.
		    default:
		    default: Guest Additions Version: 4.2.0
		    default: VirtualBox Version: 4.3
		==> default: Configuring and enabling network interfaces...
		==> default: Mounting shared folders...
		    default: /vagrant => /Users/stewartc/otto-getting-started
		    default: /otto/foundation-1 => /Users/stewartc/otto-getting-started/.otto/compiled/app/foundation-consul/app-dev
		==> default: Running provisioner: shell...
		    default: Running: inline script
		==> default: stdin: is not a tty
		==> default: [otto] Installing Consul...
		==> default: [otto] Installing dnsmasq for Consul...
		==> default: [otto] Configuring consul service: otto-getting-started
		==> default: Running provisioner: shell...
		    default: Running: inline script
		==> default: stdin: is not a tty
		==> default: [otto] Adding apt repositories and updating...
		==> default: [otto] Installing Ruby 2.2 and supporting packages...
		==> default: [otto] Installing Bundler...
		==> default: [otto] Configuring Git to use SSH instead of HTTP so we can agent-forward private repo auth...

		==> Caching SSH credentials from Vagrant...
		==> Development environment successfully created!
		    IP address: 172.16.1.230

		    A development environment has been created for writing a generic
		    Ruby-based app.

		    Ruby is pre-installed. To work on your project, edit files locally on your
		    own machine. The file changes will be synced to the development environment.

		    When you're ready to build your project, run 'otto dev ssh' to enter
		    the development environment. You'll be placed directly into the working
		    directory where you can run 'bundle' and 'ruby' as you normally would.

		    You can access any running web application using the IP above.


### Start Application

		$ otto dev ssh
		==> Executing SSH. This may take a few seconds...
		Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

		 * Documentation:  https://help.ubuntu.com/
		New release '14.04.3 LTS' available.
		Run 'do-release-upgrade' to upgrade to it.

		Welcome to your Vagrant-built virtual machine.
		Last login: Fri Sep 14 06:23:18 2012 from 10.0.2.2
		vagrant@precise64:/vagrant$ 

		> bundle && rackup --host 0.0.0.0
		Fetching gem metadata from https://rubygems.org/..........
		Fetching version metadata from https://rubygems.org/..
		Installing rack 1.6.4
		Installing rack-protection 1.5.3
		Installing tilt 2.0.1
		Installing sinatra 1.4.6
		Using bundler 1.10.6
		Bundle complete! 1 Gemfile dependency, 5 gems now installed.
		Use `bundle show [gemname]` to see where a bundled gem is installed.
		[2015-10-13 23:40:50] INFO  WEBrick 1.3.1
		[2015-10-13 23:40:50] INFO  ruby 2.2.3 (2015-08-18) [x86_64-linux-gnu]
		[2015-10-13 23:40:50] INFO  WEBrick::HTTPServer#start: pid=7269 port=9292

From this point, you can view the app in a browser by going to http://172.16.1.230:9292


### Deploying (to AWS)

The following command is the ONLY thing required to deploy to AWS (with default settings).  You'll be prompted for your AWS Access Key, Secret Key, a password to encrypt these credentials locally, and an SSH public key.  Also, you'll be asked if you want Otto to install terraform (if not already installed).

		# Create AWS Infrastructure (VPC, Security Groups, etc.)
		$ otto infra

		# Builds AWS AMI with Packer
		$ otto build

		# Deploys Application
		$ otto deploy

NOTE: Otto docs explain that in the near future, they'll be building a container to be deployed using [Nomad](https://nomadproject.io/) (as opposed to creating an AMI).  Nomad looks to be a scheduler (similar to that of Kubernetes) that has been developed by HashiCorp.

NOTE: Allowing Otto to build out the infrastructure itself without overriding any values using an Appfile, it appears that Otto will deploy the application using a c3.large instance type for use when creating the AWS AMI via Packer.

### Generated Files

The following is a view of the `.otto` directory structure generated during this process.  As you can see, there are a LOT of things that Otto handles for the end user that is completely hidden.

		$ tree .otto
		.otto
		├── appfile
		│   ├── Appfile.compiled
		│   └── version
		├── compiled
		│   ├── app
		│   │   ├── build
		│   │   │   ├── build-ruby.sh
		│   │   │   └── template.json
		│   │   ├── deploy
		│   │   │   └── main.tf
		│   │   ├── dev
		│   │   │   └── Vagrantfile
		│   │   └── foundation-consul
		│   │       ├── app-build
		│   │       │   ├── main.sh
		│   │       │   ├── upstart.conf
		│   │       │   └── vars
		│   │       ├── app-deploy
		│   │       │   └── main.sh
		│   │       ├── app-dev
		│   │       │   └── main.sh
		│   │       ├── app-dev-dep
		│   │       │   └── main.sh
		│   │       └── deploy
		│   │           ├── main.tf
		│   │           ├── module-aws
		│   │           │   ├── join.sh
		│   │           │   ├── main.tf
		│   │           │   ├── outputs.tf
		│   │           │   └── variables.tf
		│   │           ├── module-aws-simple
		│   │           │   ├── main.tf
		│   │           │   ├── outputs.tf
		│   │           │   ├── setup.sh
		│   │           │   └── variables.tf
		│   │           └── variables.tf
		│   ├── foundation-consul
		│   │   ├── app-build
		│   │   │   ├── main.sh
		│   │   │   └── upstart.conf
		│   │   ├── app-deploy
		│   │   │   └── main.sh
		│   │   ├── app-dev
		│   │   │   ├── main.sh
		│   │   │   └── upstart.conf
		│   │   ├── app-dev-dep
		│   │   │   └── main.sh
		│   │   └── deploy
		│   │       ├── main.tf
		│   │       ├── module-aws
		│   │       │   ├── join.sh
		│   │       │   ├── main.tf
		│   │       │   ├── outputs.tf
		│   │       │   └── variables.tf
		│   │       ├── module-aws-simple
		│   │       │   ├── main.tf
		│   │       │   ├── outputs.tf
		│   │       │   ├── setup.sh
		│   │       │   └── variables.tf
		│   │       └── variables.tf
		│   └── infra-otto-getting-started
		│       ├── main.tf
		│       └── outputs.tf
		└── data
		    ├── dev_ip
		    └── vagrant
		        └── machines
		            └── default
		                └── virtualbox
		                    ├── action_provision
		                    ├── action_set_name
		                    ├── creator_uid
		                    ├── id
		                    ├── index_uuid
		                    ├── private_key
		                    └── synced_folders

		28 directories, 48 files

### Teardown

		# AWS resources
		$ otto deploy destroy
		$ otto infra destroy

		# Vagrant/dev environment
		$ otto dev destroy

## Chef Provisioning

Start by setting environment variables for AWS keys

		export AWS_ACCESS_KEY_ID=accessKeyId
		export AWS_SECRET_ACCESS_KEY=secretAccessKey

### Installation

* Install [ChefDK](https://downloads.chef.io/chef-dk/)
	* This should include gem dependencies for AWS chef-provisioning support (`chef-provisioning`, `chef-provisioning-aws`)

### Build Project

IMO, the chef-provisioning 'recipes' should be managed within a cookbook.  With that said, we'll go ahead and create a cookbook for our provisioning recipes.

		# Generate cookbook
		chef generate cookbook chef-provisioning-intro

		# Generate aws recipe
		cd .\chef-provisioning-intro
		chef generate recipe aws


Update chef-provisioning-intro::aws with the following content:

		require 'chef/provisioning/aws_driver'

		with_chef_server Chef::Config[:chef_server_url],
		  :client_name => Chef::Config[:node_name],
		  :signing_key_filename => Chef::Config[:client_key]

		with_driver 'aws::us-east-1'

		machine 'mario' do
		  tag 'itsa_me'
		  converge true
		end

NOTE: Without any other settings, this will generate a key pair for SSH acccess into the provisioned machine.  All generated keys are add to `$HOME/.chef/keys`

My first attempt to deploy using default settings resulted in the following error, essentially explaining the the specified (default) instance type must be used in a VPC.

		[2015-10-13T21:34:31-04:00] INFO: [Aws::EC2::Client 400 0.233898 0 retries] run_instances(max_count:1,min_count:1,instance_type:"t2.micro",image_id:"ami-eb25688e",key_name:"chef_default") Aws::EC2::Errors::VPCResourceNotSpecified The specified instance type can only be used in a VPC. A subnet ID or network interface ID is required to carry out the request.


		    ================================================================================
		    Error executing action `converge` on resource 'machine[mario]'
		    ================================================================================

		    Aws::EC2::Errors::VPCResourceNotSpecified
		    -----------------------------------------
		    The specified instance type can only be used in a VPC. A subnet ID or network interface ID is required to carry out the request.

		    Resource Declaration:
		    ---------------------
		    # In /Users/stewartc/chef-provisioning-intro/recipes/aws.rb

		     15: machine 'mario' do
		     16:   tag 'itsa_me'
		     17:   converge true
		     18: end

		    Compiled Resource:
		    ------------------
		    # Declared in /Users/stewartc/chef-provisioning-intro/recipes/aws.rb:15:in `from_file'

		    machine("mario") do
		      action [:converge]
		      retries 0
		      retry_delay 2
		      default_guard_interpreter :default
		      chef_server {:chef_server_url=>"chefzero://localhost:8889", :options=>{:client_name=>"curtstewart", :signing_key_filename=>"/Users/stewartc/.chef/curtstewart.pem", :api_version=>"0"}}
		      driver "aws::us-east-1"
		      declared_type :machine
		      cookbook_name "@recipe_files"
		      recipe_name "/Users/stewartc/chef-provisioning-intro/recipes/aws.rb"
		      attribute_modifiers [["tags", #<Proc:0x007f9bb0e72428@/opt/chefdk/embedded/lib/ruby/gems/2.1.0/gems/cheffish-1.5.0/lib/cheffish.rb:155>]]
		      converge true
		    end

		[2015-10-13T21:34:31-04:00] INFO: Running queued delayed notifications before re-raising exception

		Running handlers:
		[2015-10-13T21:34:31-04:00] ERROR: Running exception handlers
		Running handlers complete
		[2015-10-13T21:34:31-04:00] ERROR: Exception handlers complete
		Chef Client failed. 0 resources updated in 12 seconds
		[2015-10-13T21:34:31-04:00] FATAL: Stacktrace dumped to /Users/stewartc/.chef/local-mode-cache/cache/chef-stacktrace.out
		[2015-10-13T21:34:31-04:00] ERROR: machine[mario] (@recipe_files::/Users/stewartc/chef-provisioning-intro/recipes/aws.rb line 15) had an error: Aws::EC2::Errors::VPCResourceNotSpecified: The specified instance type can only be used in a VPC. A subnet ID or network interface ID is required to carry out the request.
		[2015-10-13T21:34:31-04:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)

### Cleanup

Unfortunately, you'll have to actually write a specific cleanup recipe to handle tearing down your environment.

		cd .\chef-provisioning-intro
		chef generate recipe aws_cleanup

Update chef-provisioning-intro::aws_cleanup with the following contenr:

		require 'chef/provisioning/aws_driver'

		with_chef_server Chef::Config[:chef_server_url],
		  :client_name => Chef::Config[:node_name],
		  :signing_key_filename => Chef::Config[:client_key]

		with_driver 'aws::us-east-1'

		machine 'mario' do
		  action :destroy
		end

NOTE: There's a lot of duplication with the setup here.  I attempted to create an `aws_common` recipe, then call that using an `include_recipe` call in the other recipes, but I received the following error:

		[2015-10-13T21:29:32-04:00] WARN: MissingCookbookDependency:
		Recipe `chef-provisioning-intro::aws_common` is not in the run_list, and cookbook 'chef-provisioning-intro'
		is not a dependency of any cookbook in the run_list.  To load this recipe,
		first add a dependency on cookbook 'chef-provisioning-intro' in the cookbook you're
		including it from in that cookbook's metadata.


		Running handlers:
		[2015-10-13T21:29:32-04:00] ERROR: Running exception handlers
		Running handlers complete
		[2015-10-13T21:29:32-04:00] ERROR: Exception handlers complete
		Chef Client failed. 0 resources updated in 02 seconds
		[2015-10-13T21:29:32-04:00] FATAL: Stacktrace dumped to /Users/stewartc/.chef/local-mode-cache/cache/chef-stacktrace.out
		[2015-10-13T21:29:32-04:00] ERROR: Cookbook chef-provisioning-intro not found. If you're loading chef-provisioning-intro from another cookbook, make sure you configure the dependency in your metadata
		[2015-10-13T21:29:32-04:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)		

From here, I went back to the chef-provisioning-aws examples and added VPC resources.  Here's the final contents of chef-provisioning-intro::aws

		require 'chef/provisioning/aws_driver'

		with_chef_server Chef::Config[:chef_server_url],
		  :client_name => Chef::Config[:node_name],
		  :signing_key_filename => Chef::Config[:client_key]

		with_driver 'aws::us-east-1'

		aws_vpc "provisioning-vpc" do
		  cidr_block "10.0.0.0/24"
		  internet_gateway true
		  main_routes '0.0.0.0/0' => :internet_gateway
		end

		aws_subnet "provisioning-vpc-subnet-b" do
		  vpc "provisioning-vpc"
		  cidr_block "10.0.0.0/26"
		  availability_zone "us-east-1b"
		  map_public_ip_on_launch true
		end

		aws_subnet "provisioning-vpc-subnet-c" do
		  vpc "provisioning-vpc"
		  cidr_block "10.0.0.128/26"
		  availability_zone "us-east-1c"
		  map_public_ip_on_launch true
		end

		machine_batch do
		  machine 'mario-b' do
		    machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-b' }
		  end

		  machine 'mario-c' do
		    machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-c' }
		  end
		end

		aws_security_group "provisioning-vpc-security-group" do
		  inbound_rules [
		    {:port => 2223, :protocol => :tcp, :sources => ["10.0.0.0/24"] },
		    {:port => 80..100, :protocol => :udp, :sources => ["1.1.1.0/24"] }
		  ]
		  outbound_rules [
		    {:port => 2223, :protocol => :tcp, :destinations => ["1.1.1.0/16"] },
		    {:port => 8080, :protocol => :tcp, :destinations => ["2.2.2.0/24"] }
		  ]
		  vpc "provisioning-vpc"
		end

This configuration would not connect to the AWS instances created.  Since it's been awhile since I've configured VPC's with valid security group/firewall settings, I decided to go back to otto to generate my infrastructure (via `otto infra`), and use that as a reference architecture :)

I ultimately got lazy and gave up on the specific VPC settings to ensure SSH access.  Instead, I just updated the machine options to use a non-VPC instance type.  Here's the resulting aws recipe:

NOTE: In order to cleanup all of the created AWS resources, I had to update the cleanup recipe to ensure resources were deleted in the correct order (instance -> subnet -> security group -> vpc).  Errors such as the one below became a nightmare during the creation of the cleanup recipe.

		[2015-10-13T23:38:12-04:00] INFO: [AWS EC2 400 0.120197 0 retries] delete_subnet(:subnet_id=>"subnet-6a062841") AWS::EC2::Errors::DependencyViolation The subnet 'subnet-6a062841' has dependencies and cannot be deleted.

# Comparisons

* chef-provisioning requires much more knowledge of Chef and AWS resources
* chef-provisioning requires separate cleanup recipes to be created
* otto is limited to AWS and Virtualbox environments
* chef-provisioning has a number of drivers (See [rubygems](https://rubygems.org/search?utf8=%E2%9C%93&query=chef-provisioning) for larger list)
	* aws
	* azure
	* lxc
	* vagrant
	* vsphere
	* fog
	* docker

