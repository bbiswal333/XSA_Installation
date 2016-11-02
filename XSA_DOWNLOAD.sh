#!/bin/bash

#Components Path Constants

ROOT_DIR="/Disk1/installer"
XSA_DIR="$ROOT_DIR/XSA"
HANA_DIR="$ROOT_DIR/HANA"
DEVX_DIR="$ROOT_DIR/DEVX"
XSA_RT_DIR="$ROOT_DIR/XSA/RT"
XSA_CONT_DIR="$ROOT_DIR/XSA/CONT"

#XSA RUNTIME URL generation
echo "enter xsa_version"
read XSA_RUNTIME
xsa_rt_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.releases.xmake/com/sap/xs/onpremise/runtime/xs.onpremise.runtime.client_linuxx86_64/"$XSA_RUNTIME


#XSA ADMIN URL GENERATION
echo "enter xsa_admin"
read XSA_ADMIN
admin_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xsa/admin/sap-xsac-admin/"$XSA_ADMIN


#XSA JOB SCHEDULER URL GENERATION
echo "enter JOB SCHEDULER"
read XSA_JOB_SCHEDULER
scheduler_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xs/jobscheduler/jobscheduler-assembly/"$XSA_JOB_SCHEDULER


#XSA SHINE URL GENERATION
#echo "enter XSA SHINE"
#read XSA_SHINE
#shine_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xs/jobscheduler/jobscheduler-assembly/"$XSA_SHINE

#XSA HRTT URL GENERATION
echo "enter HRTT"
read HRTT
hrtt_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones/com/sap/xsa/hrtt/sap-xsac-hrtt/"$HRTT

#XSA DI URL GENERATION
echo "enter DI"
read DI
di_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones/com/sap/di/sap-xsac-di/"$DI

#XSA WEBIDE URL GENERATION
echo "enter DI"
read WEB_IDE
webide_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones/com/sap/devx/sap-xsac-webide/"$WEB_IDE

[ -d $ROOT_DIR ] || sudo mkdir $ROOT_DIR

[ -d $XSA_DIR ] || sudo mkdir $XSA_DIR

[ -d $HANA_DIR ] || sudo mkdir $HANA_DIR

[ -d $DEVX_DIR ] || sudo mkdir $DEVX_DIR

[ -d $XSA_RT_DIR ] || sudo mkdir $XSA_RT_DIR

[ -d $XSA_CONT_DIR ] || sudo mkdir $XSA_CONT_DIR


cd $XSA_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $xsa_rt_url

cd $XSA_CONT_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $admin_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $scheduler_url

cd $DEVX_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $hrtt_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $di_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A mtaext $di_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $webide_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A mtaext $webide_url



#wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.releases.xmake/com/sap/xs/onpremise/runtime/xs.onpremise.runtime.hanainstallation_linuxx86_64/1.0.36

