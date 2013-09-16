seafadm - Seafile Administration Web-To-CLI-Wrapper
===================================================

ABOUT:
------

Seafadm allows to do some administration tasks for Seafile (https://github.com/haiwen/seafile) from command line. It collects informations and executes commands by internally calling the web interface of Seafile, Seahub. The used BeautifulSoup module allows the command line tool to be seen as a browser from Seahub's perspective.
Using seafadm one can collect informations about users, groups, links and libraries. These objects also can be deleted. Quotas can be set for users and domains. Searches can be done in users, libraries and groups.

REQUIREMENTS:
-------------

Seafadm is tested with Python 2.7 and needs the great BeautifulSoup module from http://www.crummy.com/software/BeautifulSoup/ version 4. Fedora and CentOS users do a 

    yum install python-beautifulsoup4

Debian users install via

    apt-get install python-bs4

Then run simply on command line using the following instructions.

USAGE:
------

seafadm [option...] [command] [argument]


Valid options are:

    -c, --config      location for config file for URL, username and password
    -U, --url         URL of Seafile server, e.g. https://seafile.local
    -u, --username    username of Seafile admin account
    -p, --password    password for givern username
    -F, --force       disable confirmation for delete and quota command

Valid commands are:

    show              show informations about users, libraries, groups and links
    delete            delete users, libraries, groups and links
    quota             set quota for single users and whole domains
    search            search for users, groups and links

Arguments for show command:

    users             show all users, their ID, creation date and quota as list
    user <username>   show extra details about <username>, its libraries, shares and groups
    libs              show all libraries, their ID, owners and description as list
    groups            show all groups, their ID, owner, creation date and members as list
    group <group>     show details about single <group>
    links             show links, their ID, creation date and URL as list ordered by owner 
    all               show extra details about all users

Arguments for delete command:

    user <username>   delete <username>
    lib <reop-id>     delete library with ID <repo-id>
    link <link>       delete link <link> identified by URL or ID
    group <group>     delete group identified by group name <group>

Arguments for quota command:

    user <username> <quota>        set quota for <username> to <quota> MB
    domain <domain> <quota>        set quota for users from <domain> to <quota> MB
    domain not <domain> <quota>    set quota for users NOT from <domain> to <quota> MB
    domain min <domain> <quota>    set quota for users from <domain> to a minimum of
                                   <quota> MB

Arguments for search command:

    user <srtring>    search in users for <string>
    group <string>    search in groups for <string>
    link <string>     search in links for <string>

CONFIG FILE:
------------

The optional config file allows to omit sensitive information like username and password at the command line. These informations are stored in the config file that has to be given by the --config option and to look like that:

    [seafadm]
    url=https://seafile.example.com
    username=admin@example.com
    password=secret

EXAMPLES:
---------

Showing all users, their libraries, groups and memberships:

    seafadm -c ./seafadm.conf show all

Showing users as list:

    seafadm -c ./seafadm.conf show users

Showing details about one single user:

    seafadm -c ./seafadm.conf show user joe@example.com

Deleting an user:

    seafadm -c ./seafadm.conf delete user joe@example.com

Deleting a library:

    seafadm -c ./seafadm.conf delete lib 1c17cddc-2864-407c-8fcf-6a325964d00b

Setting quota to 10240 MB for an user:

    seafadm -c ./seafadm.conf quota user joe@example.com 10240

Setting quota to 4096 MB for users of domain example.com:

    seafadm -c ./seafadm.conf quota domain example.com 4096

Setting quota to a minimum of 20480 MB for all users of domain example.com:

    seafadm -c ./seafadm.conf quota domain min example.com 20480

Setting quota to 1 MB for all users NOT in domain example.com:

    seafadm -c ./seafadm.conf quota domain not example.com 1
