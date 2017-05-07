Vagrant.configure(2) do |config|
	config.vm.provider :virtualbox do |vb, config|
		config.vm.box = "bento/ubuntu-16.04" #We will use current Ubuntu 16.04 LTS
		vb.memory = "3096" #create a machine with 2GB of RAM
		vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"] #don't use more the half the power
		vb.name = "project_machine"
	end
	config.vm.provision "file", source: "config_files/QGIS/QGIS2.conf", destination: "/home/vagrant/.config/QGIS/QGIS2.conf"
	config.vm.synced_folder "data/", "/vagrant/data/", type: "rsync"
	config.vm.synced_folder "config_files/", "/vagrant/config_files/", type: "rsync"
	config.vm.provision "shell", path: "provisioning/provision.sh" #here is everything stroed that happens once the mashine is up and running
end
