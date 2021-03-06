#!/bin/bash

#Versione 1.1 del 23/08/2020 modificata per Fedora

#Questo file installa Dike GoSign su fedora partendo dal deb ufficiale per Ubuntu e derivate

#Variazione 

echo "Name:		dike6"
echo "Summary:	Infocert Programma di gestione firma digitale - non ufficiale"
echo "Version:	"
echo "Packager:	Marco's Box";
echo "Creatore originale:	fork del tool creato da grigolin massimo https://sourceforge.net/projects/dike6-urpmi-install/";

#Distribution:	Fedora
echo "URL:		http://www.infocert.it"
echo "Vendor:		LegalCert";
echo "ExclusiveArch:	x86_64"

echo "Requires:	nautilus-python libappindicator"
echo "Requires:	usb_modeswitch pcsc-lite pcsc-tools"

echo "Lo script provvederà ora ad installare le dipendenze";

read -n1 -r -p "Press any key to continue..." key [...]

dnf install nautilus-python
dnf install usb_modeswitch
dnf install pcsc-lite
dnf install pcsc-tools
dnf install libappindicator
dnf install libjpeg-turbo 
dnf install libjpeg-turbo-devel 
dnf install libjpeg-turbo-static 
dnf install @development-tools

echo "Ora che abbiamo installato i pacchetti necessari installiamo il programma";

mkdir dike_temp
cd dike_temp

ar x ../Dike-Gosign-installer-x86_64.deb data.tar.xz

echo "Ora estraiamo i file necessari"

tar xvJf data.tar.xz

#ora ci troviamo due directory..
#e le copiamo

cp -f -r opt /
cp -f -r usr /

echo "copie eseguite";

#Scarico e compilo jpeg8
wget http://www.ijg.org/files/jpegsrc.v8d.tar.gz
tar zxvf jpegsrc.v8d.tar.gz
cd jpeg-8d
./configure
make
sudo make install

# Roba per Dike, i link non dovrebbero servire ma il resto si
chmod 0755 /opt/dike6/Dike
ln -fs "/opt/dike6/Dike" "/usr/bin/Dike"
ln -s /usr/local/lib/libjpeg.so.8 /usr/lib64/libjpeg.so.8
cp -f /opt/dike6/res/dike_shell_ext.py /usr/lib64/nautilus/extensions-3.0/

echo "Installazione completata.... "


echo "Rimozione file temporanei"
cd ..
rm -f -r dike_temp

exit
desktop=$(xdg-user-dir DESKTOP)
cp -f /usr/share/applications/Dike6.desktop ${desktop}

echo "Grazie Per aver usato lo script. Un ringraziamento va a Grigo, autore iniziale dello script"
#aggiungiamo una fonte..

