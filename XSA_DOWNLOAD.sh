
#Components Path Constants

DIR1="Disk1"
DIR2="installer"
DIR3="XSA"
DIR4="HANA"
DIR5="DEVX"
DIR6="RT"
DIR7="CONT"

ROOT_DIR="/Disk1/installer"
XSA_DIR="$ROOT_DIR/XSA"
HANA_DIR="$ROOT_DIR/HANA"
DEVX_DIR="$ROOT_DIR/DEVX"
XSA_RT_DIR="$ROOT_DIR/XSA/RT"
XSA_CONT_DIR="$ROOT_DIR/XSA/CONT"

#XSA RUNTIME URL generation
#echo "enter xsa_version"
#read XSA_RUNTIME
xsa_rt_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.releases.xmake/com/sap/xs/onpremise/runtime/xs.onpremise.runtime.client_linuxx86_64/"$XSA_RUNTIME


#XSA ADMIN URL GENERATION
#echo "enter xsa_admin"
#read XSA_ADMIN
admin_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xsa/admin/sap-xsac-admin/"$XSA_ADMIN


#XSA JOB SCHEDULER URL GENERATION
#echo "enter JOB SCHEDULER"
#read XSA_JOB_SCHEDULER
scheduler_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xs/jobscheduler/jobscheduler-assembly/"$XSA_JOB_SCHEDULER


#XSA SHINE URL GENERATION
#echo "enter XSA SHINE"
#read XSA_SHINE
#shine_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones.xmake/com/sap/xs/jobscheduler/jobscheduler-assembly/"$XSA_SHINE

#XSA HRTT URL GENERATION
#echo "enter HRTT"
#read HRTT
hrtt_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones/com/sap/xsa/hrtt/sap-xsac-hrtt/"$HRTT

#XSA DI URL GENERATION
#echo "enter DI"
#read DI
#di_url="http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.milestones/com/sap/di/sap-xsac-di/"$DI

#XSA WEBIDE URL GENERATION
#echo "enter DI"
#read WEB_IDE
webide_di_url="http://nexus.wdf.sap.corp:8081/nexus/content/groups/build.milestones/com/sap/devx/sap-xsac-devx/"$WEBIDE_DI

#HANA URL GENERATION
hana_url="/net/sapmnt.production.makeresults.newdb_archive/HANA_WS_COR/released_weekstones/$HANA/server/linuxx86_64"


cd /
#sudo -i
#chmod 777 root

[ -d $DIR1 ] || mkdir $DIR1

cd /$DIR1

[ -d $DIR2 ] ||  mkdir $DIR2

cd $ROOT_DIR

[ -d $DIR3 ] ||  mkdir $DIR3

[ -d $DIR4 ] ||  mkdir $DIR4

[ -d $DIR5 ] ||  mkdir $DIR5

cd $XSA_DIR

[ -d $DIR6 ] ||  mkdir $DIR6

[ -d $DIR7 ] ||  mkdir $DIR7


cd $XSA_RT_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy $xsa_rt_url/xs.onpremise.runtime.client_linuxx86_64-$XSA_RUNTIME.zip

cd $XSA_CONT_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip $admin_url
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy $scheduler_url/jobscheduler-assembly-$XSA_JOB_SCHEDULER.zip

cd $DEVX_DIR
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy  $hrtt_url/sap-xsac-hrtt-$HRTT.zip
#wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy  $di_url/sap-xsac-di-$DI.zip
#wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy  $di_url/sap-xsac-di-$DI.mtaext
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy  $webide_di_url/sap-xsac-devx-$WEBIDE_DI.zip
wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy  $webide_di_url/sap-xsac-devx-$WEBIDE_DI.mtaext



#wget -nH --cut-dirs=100 --no-check-certificate --auth-no-challenge -c -r -l1 --no-parent --no-proxy -A zip http://nexus.wdf.sap.corp:8081/nexus/content/repositories/deploy.releases.xmake/com/sap/xs/onpremise/runtime/xs.onpremise.runtime.hanainstallation_linuxx86_64/1.0.36



for hanafile in "$hana_url"/*.SAR
do
  echo "$hanafile"
  cp $hanafile $HANA_DIR
done

$ROOT_DIR/XSA_INSTALL.sh
