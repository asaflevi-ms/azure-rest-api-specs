import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ServiceNetworking, "ServiceNetworkingMgmt", "python");
@@clientName(Microsoft.ServiceNetworking,
  "ServiceNetworkingManagementClient",
  "javascript"
);
