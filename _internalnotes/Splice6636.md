
## Assigning Full Administrative Privileges to a User

The default administrative user ID in Splice Machine is `splice`. If you want to configure other users to have the same privileges as the `splice` user, follow these steps:

1. Add an LDAP `admin_group` mapping for the `splice` user:
````
    <property>
        <name>splice.authentication.ldap.mapGroupAttr</name>
        <value>admin_group=splice</value>
    </property>
````

2. Assign the `admin_group` to a user: specify `cn=admin_group` in the user definition. For example, we'll add a `myUser` with these attributes:
````
dn: cn=admin_group,ou=Users,dc=splicemachine,dc=colo
sn: MyUser
objectClass: inetOrgPerson
userPassword: myPassword
uid: myUser
````

Now `myUser` belongs to the `admin_group` group, and thus gains all privileges associated with that group.
