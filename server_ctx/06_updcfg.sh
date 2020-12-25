echo "g_lb group - - i=2" >>${INFORMIXDIR}/etc/sqlhosts
echo "idsdock onsoctcp 127.0.0.1 60001 g=g_lb" >>${INFORMIXDIR}/etc/sqlhosts
sed -i "s/DBSERVERALIASES.*/DBSERVERALIASES idsdock /g" ${INFORMIXDIR}/etc/$ONCONFIG
onmode -P start idsdock
