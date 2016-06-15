Vagrant.configure("2") do |config|

  config.vm.provision "puppet"

  config.vm.define "head" do |head|
    head.vm.box = ENV['CENTOS6_BOX']
    head.vm.network "private_network", ip:"192.168.2.100"
    head.vm.hostname = "head"
#    head.vm.provision "shell", path:"head.sh"
  end

#  config.vm.define "node1" do |node1|
#    node1.vm.box = ENV['CENTOS6_BOX']
 #   node1.vm.hostname = "node1"
  #  node1.vm.network "private_network", ip:"192.168.2.101"
  #end
  #config.vm.define "node2" do |node2|
   # node2.vm.box = ENV['CENTOS6_BOX']
    #node2.vm.hostname = "node2"
    #node2.vm.network "private_network", ip:"192.168.2.102"
  #end
end
