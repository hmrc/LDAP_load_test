!/bin/bash

# setup
LDAP_HOST=directory.staging.tools.mdtp
CONCURRENT_CALLS=1
TOTAL_CALLS=1

# search
SEARCH_SCOPE=sub
JOB_FILTER="(cn=nikhil.sharma)"
JOB_FILTER="(name=nikhil.sharma)"
JOB_FILTER="(sAMAccountName=nikhil.sharma)"
JOB_FILTER="(uid=nikhil.sharma)"

BASEDN="ou=people,ou=digital,dc=digital,dc=hmrc,dc=gov,dc=uk"

# credentials
LDAP_USER=`credstash -r eu-west-2 get sensu_ad_check_user role=auth-infrastructure`
LDAP_PASSWORD=`credstash -r eu-west-2 get sensu_ad_check_password role=auth-infrastructure`

# constants
PROTOCOL=ldaps
LDAP_PORT=636
HOST=${PROTOCOL}://${LDAP_HOST}:${LDAP_PORT}/
VERBOSITY=0 # > 1 gives worker debug to stdout

# runs the lb tool for load testing ldap bind connections
# ./lb bind -v ${VERBOSITY} -c ${CONCURRENT_CALLS} -n ${TOTAL_CALLS} -D ${LDAP_USER} -w ${LDAP_PASSWORD} ${HOST}

./lb search -v ${VERBOSITY} -c ${CONCURRENT_CALLS} -n ${TOTAL_CALLS} -D ${LDAP_USER} -w ${LDAP_PASSWORD} -a ${JOB_FILTER} -s ${SEARCH_SCOPE} -b ${BASEDN} ${HOST}

