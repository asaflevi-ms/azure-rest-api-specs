import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(LiftrBase.Versions)
namespace LiftrBase;

@doc("Supported versions for LiftrBase resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v1_preview: "2023-06-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_08_27_preview: "2024-08-27-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_08_27: "2024-08-27",
}

@doc("Marketplace subscription status of a resource.")
union MarketplaceSubscriptionStatus {
  string,

  @doc("Purchased but not yet activated")
  PendingFulfillmentStart: "PendingFulfillmentStart",

  @doc("Marketplace subscription is activated")
  Subscribed: "Subscribed",

  @doc("This state indicates that a customer's payment for the Marketplace service was not received")
  Suspended: "Suspended",

  @doc("Customer has cancelled the subscription")
  Unsubscribed: "Unsubscribed",
}

@added(Versions.v2024_08_27_preview)
@added(Versions.v2024_08_27)
@doc("Subscription renewal mode")
union RenewalMode {
  string,

  @doc("Automatic renewal")
  Auto: "Auto",

  @doc("Manual renewal")
  Manual: "Manual",
}

@doc("A string that represents a URI.")
scalar Uri extends string;

@doc("Marketplace details for an organization")
model MarketplaceDetails {
  @doc("Azure subscription id for the the marketplace offer is purchased from")
  subscriptionId?: string;

  @doc("Marketplace subscription status")
  subscriptionStatus?: MarketplaceSubscriptionStatus;

  @doc("Offer details for the marketplace that is selected by the user")
  offerDetails: OfferDetails;
}

@doc("Offer details for the marketplace that is selected by the user")
model OfferDetails {
  @doc("Publisher Id for the marketplace offer")
  publisherId: string;

  @doc("Offer Id for the marketplace offer")
  offerId: string;

  @doc("Plan Id for the marketplace offer")
  planId: string;

  @doc("Plan Name for the marketplace offer")
  planName?: string;

  @doc("Plan Display Name for the marketplace offer")
  termUnit?: string;

  @doc("Plan Display Name for the marketplace offer")
  termId?: string;

  @added(Versions.v2024_08_27_preview)
  @added(Versions.v2024_08_27)
  @doc("Subscription renewal mode")
  renewalMode?: RenewalMode;

  @added(Versions.v2024_08_27_preview)
  @added(Versions.v2024_08_27)
  @doc("Current subscription end date and time")
  @visibility(Lifecycle.Read)
  endDate?: utcDateTime;
}

@doc("Reusable representation of an email address.")
@pattern("^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")
scalar email extends string;

@doc("User details for an organization")
model UserDetails {
  @doc("First name of the user")
  firstName: string;

  @doc("Last name of the user")
  lastName: string;

  @doc("Email address of the user")
  emailAddress: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties {
  @doc("Marketplace details of the resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  marketplace: MarketplaceDetails;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Properties specific to Single Sign On Resource")
model SingleSignOnProperties {
  @doc("State of the Single Sign On for the organization")
  singleSignOnState?: SingleSignOnStates;

  @doc("AAD enterprise application Id used to setup SSO")
  enterpriseAppId?: string;

  @doc("URL for SSO to be used by the partner to redirect the user to their system")
  singleSignOnUrl?: Uri;

  @doc("List of AAD domains fetched from Microsoft Graph for user.")
  aadDomains?: string[];

  @visibility(Lifecycle.Read)
  @doc("Provisioning State of the resource")
  provisioningState?: ResourceProvisioningState;
}

@doc("Various states of the SSO resource")
union SingleSignOnStates {
  string,

  @doc("Initial state of the SSO resource")
  "Initial",

  @doc("State of the SSO resource when it is enabled")
  "Enable",

  @doc("State of the SSO resource when it is disabled")
  "Disable",
}
