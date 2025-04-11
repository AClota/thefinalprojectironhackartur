param clusterName string = 'expensyAksCluster'
param location string = 'uaenorth'
param nodeCount int = 3
param nodeVmSize string = 'Standard_DS2_v2'
param sshPublicKey string

resource aksCluster  'Microsoft.ContainerService/managedClusters@2023-01-01' = {
  name: clusterName
  location: location
  properties: {
    dnsPrefix: clusterName
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: nodeCount
        vmSize: nodeVmSize
        osType: 'Linux'
        osDiskSizeGB: 10
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
    linuxProfile: {
        adminUsername: 'azureuser'
        ssh: {
          publicKeys: [
            {
              keyData: sshPublicKey
            }
          ]
        }
      }
      addonProfiles: {
        omsagent: {
          enabled: true
        }
      }
      enableRBAC: true
      networkProfile: {
        loadBalancerSku: 'standard'
        networkPlugin: 'azure'
      }
}

}
