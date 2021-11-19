

targetScope = 'subscription'

resource policy1 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'Cox-Demo-Policy-1'
  properties: {
    displayName: 'Cox-Demo Policy 1'
    description: 'This policy audits if HTTPS Traffic Only for Storage Accounts is disabled. If not enabled you will be out of compliance.'
    metadata: {
      category: '[SCGL]: Storage'
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            not: {
              field: 'Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'
              equals: 'True'
            }
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

resource policy2 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'Cox-Demo-Policy-2'
  properties: {
    displayName: 'Cox-Demo Policy 2'
    description: 'This policy audits if HTTPS Traffic Only for Storage Accounts is disabled. If not enabled you will be out of compliance.'
    metadata: {
      category: '[SCGL]: Storage'
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            not: {
              field: 'Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'
              equals: 'False'
            }
          }
        ]
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

resource policyInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = if (policy1.id != '' && policy2.id != '') {

  name: 'cox-demo-Initiative'
  properties: {
    displayName: 'cox-demo-Initiative 1'
    description: 'test demo for cox'
    policyType: 'Custom'
    metadata: {
      category: 'Tags'
    }

    policyDefinitions: [
      {
        policyDefinitionId: policy1.id
      }
      {
        policyDefinitionId: policy2.id
      }
    ]
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = if (policyInitiative.id != '') {
  name: policyInitiative.name
  properties: {
    policyDefinitionId: policyInitiative.id
    displayName: policyInitiative.name
  }
}
