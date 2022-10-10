seafadm - Seafile CLI Administration
====================================

ABOUT:
------

Seafadm allows to do some administration tasks for Seafile (https://github.com/haiwen/seafile) from command line. It collects informations and executes commands by internally calling the web interface of Seafile, Seahub. The used BeautifulSoup module allows the command line tool to be seen as a browser from Seahub's perspective.
Using seafadm one can collect informations about users, groups, links and libraries. These objects also can be deleted. Quotas can be set for users and domains. Searches can be done in users, libraries and groups. Reports can be generated to be sent to users by mail.

**Attention:** I try to keep as close as possible with seafadm to the official Seafile releases. There are minor differences between releases which make small corrections necessary. Especially if you use an older version of Seafile you will need to use an older one of seafadm too. See the tags to find a matching version.

REQUIREMENTS:
-------------

Seafadm is tested with Python 2.7 and needs the great BeautifulSoup module from http://www.crummy.com/software/BeautifulSoup/ version 4 as well as the Python Requests library from http://docs.python-requests.org. Fedora and CentOS users do a 

    yum install python-beautifulsoup4 python-requests

Debian users install via

    apt-get install python-bs4 python-requests

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
    add               add users, libraries and files
    update            update user password
    delete            delete users, libraries, groups and links
    quota             set quota for single users and whole domains
    search            search for users, groups and links
    report            generate report per user to be sent by mail
    check             check for invalid links
    clean             check for invalid links and delete them

Arguments for show command:

    users             show all users, their ID, creation date and quota as list
    user <username>   show extra details about <username>, its libraries, shares and groups
    libs              show all libraries, their ID and owners as list
    groups            show all groups, their ID, owner, creation date and members as list
    group <group>     show details about single <group>
    links             show links, their ID, creation date and URL as list ordered by owner
    all               show extra details about all users

Arguments for add command:

    user <email> <password>     add user <email> with password <password>
    library <name> <email>      add library <name> for owner with <email>
    files <filepath> <repo-id>  add file from <filepath> to <repo-id>

Arguments for update command:

    password <email> <new_password>     update <email> password with <new_password>

Arguments for delete command:

    user <username>   delete <username>
    lib <repo-id>     delete library with ID <repo-id>
    link <link>       delete link <link> identified by URL or ID
    group <group>     delete group identified by group name <group>

Arguments for quota command:

    user <username> <quota>        set quota for <username> to <quota> MB
    domain <domain> <quota>        set quota for users from <domain> to <quota> MB
    domain not <domain> <quota>    set quota for users NOT from <domain> to <quota> MB
    domain min <domain> <quota>    set quota for users from <domain> to a minimum of
                                   <quota> MB

Arguments for search command:

    user <string>    search in users for <string>
    group <string>    search in groups for <string>
    link <string>     search in links for <string>

Arguments for report command:

    user <username>   generate report for user <username>, to be sent by mail for example

Arguments for check command:

    links             check validity of links and display them ordered by validity

Arguments for clean command:

    links                       check validity of links and delete them if invalid
    garbage [threads] [path]    run seaf_gc threads for faster garbace collection
                                [threads] defaults to 10 and [path] to /opt/seafile


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

Adding an user:

    seafadm -c ./seafadm.conf add user joe@example.com bar1234

Adding a library:

    seafdm -c  ./seafadm.conf add library 'Joe Library' joe@example.com

Adding a file:

    seafdm -c  ./seafadm.com add file './joe photo.jpg' 1c17cddc-2864-407c-8fcf-6a325964d00b 

Update user password:

    seafdm -c  ./seafadm.conf update password joe@example.com foo1234

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

Setting quota to 1 MB for all users NOT in domain example.com:share/link/

    seafadm -c ./seafadm.conf quota domain not example.com 1

Search for user joe in users:

    seafadm -c ./seafadm.conf search user joe

Generate report for user joe@example.com

    seafadm -c ./seafadm.conf report user joe@example.com

Check validity of links

    seafadm -c ./seafadm.conf check links

Delete invalid links

    seafadm -c ./seafadm.conf clean links
