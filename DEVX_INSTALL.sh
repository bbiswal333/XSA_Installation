
#DEVX Installation

echo "Retriving Component Directories..  ************************************************"

#Components Path Constants

ROOT_DIR="/Disk1/installer"
XSA_DIR="$ROOT_DIR/XSA"
HANA_DIR="$ROOT_DIR/HANA"
DEVX_DIR="$ROOT_DIR/DEVX"
XSA_RT_DIR="$ROOT_DIR/XSA/RT"
XSA_CONT_DIR="$ROOT_DIR/XSA/CONT"
HANA_DATABASE_DIR="$ROOT_DIR/HANA/SAP_HANA_DATABASE"

hostnameFQN="mo-a58d1f0f1.mo.sap.corp"
secret="Toor1234" \
org="XS" \
space="PROD" \

echo "Root Dir : $ROOT_DIR"
echo "XSA Dir : $XSA_DIR"
echo "HANA Dir : $HANA_DIR"
echo "DEVX Dir : $DEVX_DIR"
echo "RT Dir : $XSA_RT_DIR"
echo "CONT Dir : $XSA_CONT_DIR"

echo "Preparing for DEVX installation *****************************************************"

#### LOGIN TO XSA
    echo; \
    if ! xs login -a https://$hostnameFQN:30030 -u xsorgmanager -p $secret -o $org -s $space --skip-ssl-validation; then exit 1; fi; \
	
#### Installing XS Controller
echo "Installing XSA Controller"

	echo "XS Services Installation starts ...  ********************"
	if ! xs install $XSA_CONT_DIR/jobscheduler-assembly-*.zip -o ALLOW_SC_SAME_VERSION; then exit 1; fi;\
	echo "XS Services Installation completed ...  ********************"
	
	echo "XS Admin Installation starts ...  ********************"
	if ! xs install $XSA_CONT_DIR/sap-xsac-admin-*-XSACMONITORING*.zip -o ALLOW_SC_SAME_VERSION; then exit 1; fi;\
	echo "XS Admin Installation completed ...  ********************"

echo "Installing XSA Controller completed successfully"

#### Installing DEVX Components
echo "Installing DEVX Components"

	echo "HRTT Installation starts ...  ********************"
	if ! xs install $DEVX_DIR/sap-xsac-hrtt-*.zip -o ALLOW_SC_SAME_VERSION; then exit 1; fi;\
	echo "HRTT Installation completed ...  ********************"
	
	#echo "DI Installation starts ...  ********************"
	#if ! xs install $DEVX_DIR/sap-xsac-di-*.zip -e $DEVX_DIR/sap-xsac-di-*.mtaext -o \
	#ALLOW_SC_SAME_VERSION; then exit 1; fi;\
	#echo "DI Installation completed ...  ********************"
	
	echo "WEBIDE and di Installation starts ...  ********************"
	if ! xs install $DEVX_DIR/sap-xsac-devx-*.zip -e $DEVX_DIR/sap-xsac-devx-*.mtaext -o \
	ALLOW_SC_SAME_VERSION; then exit 1; fi;\
	echo "WEBIDE and di Installation completed ...  ********************"

echo "Installing DEVX Components completed successfully"

echo "XSA System has been successfully created !!"
