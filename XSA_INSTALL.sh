
#XSA Installation

echo "Retriving Component Directories..  ************************************************"

#Components Path Constants

ROOT_DIR="/Disk1/installer"
XSA_DIR="$ROOT_DIR/XSA"
HANA_DIR="$ROOT_DIR/HANA"
DEVX_DIR="$ROOT_DIR/DEVX"
XSA_RT_DIR="$ROOT_DIR/XSA/RT"
XSA_CONT_DIR="$ROOT_DIR/XSA/CONT"
HANA_DATABASE_DIR="$ROOT_DIR/HANA/SAP_HANA_DATABASE"

echo "Root Dir : $ROOT_DIR"
echo "XSA Dir : $XSA_DIR"
echo "HANA Dir : $HANA_DIR"
echo "DEVX Dir : $DEVX_DIR"
echo "RT Dir : $XSA_RT_DIR"
echo "CONT Dir : $XSA_CONT_DIR"

echo "Preparing for installation *****************************************************"

#Installation Parameters
saphome="/usr/sap/hana"

system_user_password="manager"
org_manager_password="Toor1234"
password="trextrex"
sapadm_password="Toor1234"
xs_master_password="Toor1234"

sapadm_user="J20"
xsadm_user="j20adm"
org_manager_user="xsorgmanager"
org_name="XS"
hostnameFQN="mo-a58d1f0f1.mo.sap.corp"



## Extracting HANA and XSA RT SAR

sapcar=$(ls $ROOT_DIR/*.EXE); \
if [ ! "${sapcar}" ]; then exit 1; fi; \
chmod 7777 $sapcar; \
echo $sapcar;

echo "XSA RT Extarcting started.. ****************************************"

if ! $sapcar -xf $XSA_DIR/xs.onpremise.runtime.hanainstallation*.SAR  -R $XSA_RT_DIR; then \
exit 1;fi; \

echo "XSA RT Extarcting Completed.. ************************************************"

echo "HANA server Extarcting started..  ***********************************************"

if ! $sapcar -xf $HANA_DIR/*.SAR  -R $HANA_DIR; then \
exit 1;fi; \

echo "HANA server Extarcting Completed.."

#### HANA XSA RT INSTALLATION

echo "HANA XSA Installation started..  ****************************************************"
chmod 7777 $HANA_DATABASE_DIR; \
mkdir -p $saphome/{shared,data,log}; \
if ! $HANA_DATABASE_DIR/hdblcm \
	--action=install \
	--system_usage=custom \
	--add_local_roles=xs_worker \
	--import_xs_content=yes \
	--remote_execution=ssh \
    --install_hostagent=off \
	--sapmnt=$saphome/shared --datapath=$saphome/data --logpath=$saphome/log \
	--component_dirs=$XSA_RT_DIR/,$XSA_CONT_DIR/ \
	--components=all -p $password\
	--system_user_password=$system_user_password \
	--sapadm_password=$sapadm_password -s $sapadm_user \
	--xs_master_password=$xs_master_password \
	--org_name=$org_name \
	--org_manager_user=$org_manager_user \
	--org_manager_password=$org_manager_password \
	--hostname=$hostnameFQN -b; then exit 1;fi
	
	echo "HANA XSA RT Installation SUCCESS !!!    ***************************************************"
	
### switching user
echo "switching to user $xsadm_user"

su - $xsadm_user -c $ROOT_DIR/DEVX_INSTALL.sh
