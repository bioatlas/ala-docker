#!/bin/bash

#update geoserver password
curl -v -u admin:geoserver -XPUT -H "Content-type: application/xml" -d "<userPassword><newPassword>$PASS</newPassword></userPassword>" $GEOSERVER_URL/rest/security/self/password

mkdir -p $CATALINA_HOME/webapps/geoserver/data/layout
wget -O $CATALINA_HOME/webapps/geoserver/data/layout/scale.xml https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/scale.xml

#create workspace
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/nurc?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/cite?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/it.geosolutions.html?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/sde?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/sf?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/tiger?recurse=true
#curl -v -u $USERNAME:$PASS -XDELETE $GEOSERVER_URL/rest/workspaces/topp?recurse=true
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<workspace><name>ALA</name></workspace>" $GEOSERVER_URL/rest/workspaces

#create LayersDB store
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<dataStore><name>LayersDB</name><connectionParameters><host>$LAYERS_DB_HOST</host><port>$LAYERS_DB_PORT</port><database>$LAYERS_DB_NAME</database><schema>public</schema><user>$LAYERS_DB_USERNAME</user><passwd>$LAYERS_DB_PASSWORD</passwd><dbtype>postgisng</dbtype></connectionParameters></dataStore>" $GEOSERVER_URL/rest/workspaces/ALA/datastores

#create styles
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<style><name>distributions_style</name><filename>distributions_style.sld</filename></style>" $GEOSERVER_URL/rest/styles
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<style><name>envelope_style</name><filename>envelope_style.sld</filename></style>" $GEOSERVER_URL/rest/styles
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<style><name>alastyles</name><filename>alastyles.sld</filename></style>" $GEOSERVER_URL/rest/styles
curl -v -u $USERNAME:$PASS -XPOST -H "Content-type: text/xml" -d "<style><name>points_style</name><filename>points_style.sld</filename></style>" $GEOSERVER_URL/rest/styles

#upload styles
wget -O /tmp/distributions_style.sld https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/distributions_style.sld
wget -O /tmp/envelope_style.sld https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/envelope_style.sld
wget -O /tmp/alastyles.sld https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/alastyles.sld
wget -O /tmp/points_style.sld https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/points_style.sld
curl -v -u $USERNAME:$PASS -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -d @/tmp/distributions_style.sld $GEOSERVER_URL/rest/styles/distributions_style
curl -v -u $USERNAME:$PASS -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -d @/tmp/envelope_style.sld $GEOSERVER_URL/rest/styles/envelope_style
curl -v -u $USERNAME:$PASS -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -d @/tmp/alastyles.sld $GEOSERVER_URL/rest/styles/alastyles
curl -v -u $USERNAME:$PASS -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -d @/tmp/points_style.sld $GEOSERVER_URL/rest/styles/points_style

#create layer
curl -u $USERNAME:$PASS -XPOST -H 'Content-type: text/xml' -T geoserver.objects.xml  $GEOSERVER_URL/rest/workspaces/ALA/datastores/LayersDB/featuretypes
curl -u $USERNAME:$PASS -XPOST -H 'Content-type: text/xml' -T geoserver.distributions.xml  $GEOSERVER_URL/rest/workspaces/ALA/datastores/LayersDB/featuretypes
curl -u $USERNAME:$PASS -XPOST -H 'Content-type: text/xml' -T geoserver.points.xml  $GEOSERVER_URL/rest/workspaces/ALA/datastores/LayersDB/featuretypes

#assign styles to layers

curl -u $USERNAME:$PASS -XPUT -H 'Content-type: text/xml' -d '<layer><defaultStyle><name>distributions_style</name><workspace>ALA</workspace></defaultStyle></layer>' $GEOSERVER_URL/rest/layers/ALA:Objects
curl -u $USERNAME:$PASS -XPUT -H 'Content-type: text/xml' -d '<layer><defaultStyle><name>distributions_style</name><workspace>ALA</workspace></defaultStyle></layer>' $GEOSERVER_URL/rest/layers/ALA:Distributions
curl -u $USERNAME:$PASS -XPUT -H 'Content-type: text/xml' -d '<layer><defaultStyle><name>points_style</name><workspace>ALA</workspace></defaultStyle></layer>' $GEOSERVER_URL/rest/layers/ALA:Points

#additional actions

#upload icon
wget -O /tmp/marker.png https://github.com/AtlasOfLivingAustralia/spatial-database/raw/master/marker.png
#NOT sure if GeoServer allows to upload png to ./styles. May need to use ftp service


echo ""
echo "May need to edit /etc/hosts and re-run"
echo "May need to login to geoserver, edit layer, 'Edit sql view' and resave for layers Objects and Distributions if layer previews fail"
echo ""
