# Linking Jail Configs

## Intro
To keep things simple, you can easily link jail configs together, for example you can make the settings of your MariaDB jail accessable to your nextcloud jail.
This can be done using a variable with the name: `link_$Name`, where $Name is just a description and the value in config.yml would be the actual jail to connect to.

For example:
`link_testjail: thisismytestjail`

Would link "thisismytestjail" to your current jail.

## using linked jails

Once setup one can reach all the variables of the linked jail using the following syntax:
`link_$Name_$variable`

For example if we want the ipv4 address of the jail we linked earlier, during the install of another jail, we would do:
`${link_testjail_ip4_addr}`
	
