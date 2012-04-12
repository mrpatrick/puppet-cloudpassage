# cloudpassage.com module for puppet

## Module Installation

* Add the 'cloudpassage' folder into your module path
* Include the class and configure the relevant variables for your Cloud Passage account found on the 'API Keys' tab of your 'Site Administration' page.

EXAMPLE:

class { 'cloudpassage':
  api_key  => 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  repo_key => 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  tags     => 'xxxxx'
}
