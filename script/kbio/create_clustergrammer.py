
#from sys import argv
from clustergrammer import Network

net = Network()
net.load_file('mat.txt')
#argv[1]
# calculate clustering using default parameters 
net.cluster()

# save visualization JSON to file for use by front end
net.write_json_to_file('viz', 'kbio_mhci_view.json')
