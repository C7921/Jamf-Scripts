# Jamf Scripts

Collection of scripts (and hopefully apps!) that is slowly growing for use with Jamf Pro. These are designed to help with computer management in Jamf but they do require and expect some level of scripting knowledge, including a certain level of comfort using Jamf Pro.
Please feel free to add and suggest changes to anything you find on here. All are welcome.

## Getting Started

Due to the fact that this is a spare time project, there may not be 'releases' for all the scripts to download. My best suggestion to use these would be to download to ZIP file for each of the ones you wish to use, curl (or wget) them, or simply copy and paste from the RAW view.
_Note: These scripts can mostly be used outside of Jamf Pro. However they do loose some purpose and functionality when management isn't the goal and Jamf Pro is missing to tie them all together._

### Prerequisites

- Any installation of recent Jamf Pro (formerly Casper Suit).
- Comfortable using, installing and running scripts from said Jamf Pro install.
- Some level of comfort with bash scripts. (Mainly the basics).
- Patience with youself. And me! :wink:


## Running Scripts

Best methods for using the scripts
1. As a policy payload (Also used with custom triggers to call other scripts/policies)
2. Extension attributes
3. Stored in locked local directory to user and run via command via policy.
4. Get more creative than me...

### The breakdown

Depending on the purpose and goal of the script really depends on the way to deploy it.
For example, a script that updates Google Chrome can be used a Self Service item, (or other trigger) or as a provision trigger in a setup script.

Installing scripts as Extension Attributes can be useful for gathering extra information or creating a custom smart group. Whatever the purpose it's a powerful feature.


## Built With

* [Atom](https://github.com/atom) - Main text editor
* [Sublime Text](https://www.sublimetext.com/) - Secondary text editor
* [Jamf Pro](https://www.jamf.com/products/jamf-pro/) - Obviously, the platform.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/C7921/Jamf-Scripts).


## Authors

* **Connor Sanders** - *Initial work*

See also the list of [contributors] who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Obviously, I didnt make Jamf Pro.
* I am confident that I have reference any code that has been lifted elsewhere. If I am missing something, please let me know.
* Safety first.
