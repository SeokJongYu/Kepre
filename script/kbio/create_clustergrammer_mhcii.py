
#from sys import argv
from clustergrammer import Network

net = Network()
net.load_file('mat.txt')
#argv[1]
# calculate clustering using default parameters 
net.cluster()

# save visualization JSON to file for use by front end
net.write_json_to_file('viz', 'kbio_mhcii_view.json')

net2 = Network()
net2.load_file('mat2.txt')
#argv[1]
# calculate clustering using default parameters 
net2.cluster()

# save visualization JSON to file for use by front end
net2.write_json_to_file('viz', 'kbio_mhcii_view_summary.json')