setwd('C:\\Users\\ASUS\\Desktop\\R p\\analyticstraining')

# Install the googleTagManageR and tidyverse package from CRAN --------------------------

if(interactive()){
  install.packages(c("googleTagManageR",
                     "tidyverse",
                     "DT"))
}


# load the libraries -------------------------------------------------------


library(googleTagManageR)
library(tidyverse)
library(DT)


gtm_auth() # Let's authenticate

#  List all accounts a user has access to his GTM account
gtmAccounts = gtm_accounts_list()

View(gtmAccounts)

#  Save the AccountId
Accountid = 6002974320

# List account metadata

gtm_meta_data = gtm_accounts_get(Accountid)

View(gtm_meta_data)

# List all containers from the account
containers = gtm_containers_list(Accountid)


View(containers)

#  Save the container ID
containerID = 38730677

# List the Environment
Environment = gtm_environments_list(account_id = Accountid,
                                    container_id = containerID)

#  Use the datatable function from DT package
Environment %>% 
  datatable()

#  List the Workspace

workspace = gtm_workspaces_list(account_id = Accountid,
                                container_id = containerID)
workspace %>% 
  View()

#  Save the Workspace ID
workspaceId = 15


View(Triggers)

#  List out the tags 

GTMTags = gtm_tags_list(Accountid,
                        containerID,
                        workspaceId)

#  View the Tags

GTMTags %>% 
  datatable()


#  List out the Triggers 

Triggers = gtm_triggers_list(Accountid,
                             containerID,
                             workspaceId)


#  View the tiggers

Triggers %>% 
  View()

#  Let's create a Demo Trigger Tag = "Page View"

trigger = list(
  name = "Demo Trigger",
  type = "pageview"
)

#  Use the gtm_create_trigger to push the trigger to GTM Interface

GTMTrigger = gtm_triggers_create(account_id = Accountid,
                                 container_id = containerID,
                                 workspace_id = workspaceId,
                                 trigger_object = trigger)


#  Save it as a Tibble 
Triggers = Triggers %>% 
  as_tibble()

#  Create a DEMO Universal Google Analytics Tag

tag = list(
  name = "Universal Demo Google Analytics",
  type = "ua",
  parameter = list(
    list(type = "template",
         key = "trackingId",
         value = "UA-187584011-1"
    ),
    list(
      type = "template",
      key = "trackType",
      value = "TRACK_PAGEVIEW"
    )
  ), # Copy the TriggerID from the Triggers DataFrame
  #  This would be the recent Demo Page View Trigger created
  firingTriggerId = 22 
)

#  Publish the tag to the GTM Interface
gtm_tags_create(Accountid,
                containerID,
                workspaceId,
                tag_object = tag)

#  Do a preview in GTM and check if the tags and triggers are firing correctly using Google Analytics and GTM debugger
#  https://analytics.google.com/
#  https://tagassistant.google.com/

#  Next publish the new version 

Version = 12

getVersion = gtm_versions_get(account_id = Accountid,
                              container_id = containerID,
                              version_id = Version)

publish = gtm_versions_update(account_id = Accountid,
                              container_id = containerID,
                              version_id = Version,
                              name = "New Demo Tag",
                              description = "Demo Tag done with R")
gtm_workspaces_list(Accountid,container_id = containerID)
