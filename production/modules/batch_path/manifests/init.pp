#
# Batch path node selector
#
class batch_path {

  info('[deploop] Batch node class')  
  $hadoop_security_authentication = extlookup('hadoop_security', 'simple')
  $nameservice_id = extlookup('hadoop_ha_nameservice', 'openbuscluster')
  $hadoop_namenode_nn1 = extlookup('hadoop_namenode_nn1')
  $hadoop_namenode_nn2 = extlookup('hadoop_namenode_nn2')
  $hadoop_resourcemanager = extlookup('hadoop_resourcemanager')

  case $::deploop_role {
    nn1: {
      info("[deploop] Active NameNode NN1 for HDFS HA")
      info("[deploop] The hostname ${fqdn} has NN1 role")
      include hadoop_nn1
    }
    nn2: {
      info("[deploop] Standby NameNode NN2 for HDFS HA")
      include hadoop_nn2
    }
    rm: {
      info("[deploop] Standby NameNode NN2 for HDFS HA")
      include hadoop_rm
    }
    dn: {
      info("[deploop] HDFS Worker DataNode")
      include hadoop_dn
    }
    default: {
      info("[deploop] ERROR undefined role: ${deploop_role}")
    }
  }
}
