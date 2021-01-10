#!/bin/bash
[ -d conky_light\ 8core_work/ ] && rm -fr conky_light\ 8core_work/
[ -d TeejeeTech ] && rm -fr TeejeeTech
cp -r  ~/.conky/TeejeeTech ./
cp -r  ~/.conky/Extra/conky_light\ 8core_work/ ./
[ -f conky_light_8core_work.zip ] && rm conky_light_8core_work.zip
[ -f TeejeeTech.zip ] && rm TeejeeTech.zip

zip -r conky_light_8core_work.zip conky_light\ 8core_work/
zip -r TeejeeTech.zip TeejeeTech/
sed -n '1,/#end_of_first_part/p' conky_installer_core  > conky_installer.sh
shar -c xz -g 9 *.zip | sed '1,2d' | sed 's/#\!\/bin\/sh/#\!\/bin\/bash/' | tee -a conky_installer.sh
sed -i '/lock_dir\=/i \! \[ \-x \"\`which shar 2\>\/dev\/null\`\" \] \&\& sudo apt install sharutils' conky_installer.sh
sed -i '$ a unzip\ conky_light_8core_work.zip\ -d $HOME/.conky/Extra' conky_installer.sh
sed -i '$ a unzip\ TeejeeTech.zip\ -d $HOME/.conky/' conky_installer.sh
echo "sudo unzip conky_light_8core_work.zip -d /etc/skel/.conky/Extra" >> conky_installer.sh
echo "sudo unzip TeejeeTech.zip -d /etc/skel/.conky/" >> conky_installer.sh
sed -i '/exit 0/d' conky_installer.sh
sed -n '/#end_of_first_part/,$p' conky_installer_core >> conky_installer.sh
sed -i '/^#[a-z]/d' conky_installer.sh
sed -i '/^# [^=]/d' conky_installer.sh
sed -i '/^#$/d' conky_installer.sh
#Todas las líneas eliminadas anteriormente, han dejado líneas vacías en el script. Las elimino también:
sed -i '/^$/d' conky_installer.sh
#Añadimos comentarios sobre autoría,etc (en orden inverso a como han de aparecer):
sed -i '2 i # Use installer_creator.sh script provided by the author, instead.' conky_installer.sh
sed -i '2 i # This scrip is automatically generated. It is too big to be directly edited.' conky_installer.sh
sed -i '2 i # Script made by Francisco José de Torres' conky_installer.sh
#Al resultado, le damos permisos de ejecución:
chmod +x conky_installer.sh
