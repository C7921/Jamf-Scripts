## Jamf Pro Extension Attributes

Attributes that check for items on the Dock as well as checking for particular files such as LaunchAgents etc.

These Extension Attributes (EA's) where created to allow for a more flexible user dock to be deployed. This was original done with a FUT dmg file but using a policy to refresh recently imaged devices or a loan fleet made it easier to track which computer would simply add or read-add to the Dock.

These EA's could also be used a script that runs via a policy to then re-deploy each Dock item individually.
Would end up with multiple dock policies though.

Original Idea:
- Wanted a easy and pretty flexible way to deploy the user dock to computers.
  - Used to use a FUT DMG but when a device was re-imaged. If apps were updated via an At Reboot Script there would be issues with the dock displaying question marks etc.


Optional Improved Ideas:
- Each EA would check to see if the required Dock items are installed.
  1.  A smart group would then be created to scope a policy that would re-deploy the dock icons as required.

- Using a single policy that re-deploys the dock icons. (Using a custom trigger?)
  1. Scoped to all computers, ongoing but only a custom command line trigger.

- Use the Ea's in a script that will check for each individual dock item.
  1. For each missing dock item there would be a policy with either a custom trigger or by policy ID
  2. This would have a large number of policies that would install each missing dock item.
