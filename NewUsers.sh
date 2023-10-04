#!/bin/bash
clear

# Previament hem creat els grups: desarrollo, soporte i marketing.
# groupadd Desarrollo
# groupadd Soporte
# groupadd Marketing

# També a dins de /home/james/final hem creat 3 carpetes, una per cada departament.
# A dins de desarrollo hem creat dos axius de scripts.
# Dins de soporte dos arxius de guias.
# Dins de marketing dos de carteles.

# Tenim un arxiu amb la seguent estructura:
# Nom;Cognoms;Departament;NumExtensió;DataNaixament;DNI

# Ha de cumplir:
# - El Departament sigui un dels tres
# - El DNI ha de ser de 9 digits
# - Formem el login nom_cognom1 irrepetible

# Si existeixen les llistes que es creen les borrem:
# Departaments:
if [ -f /home/james/final/LlistaDepartament.txt ]
	then
	`rm -rf /home/james/final/LlistaDepartament.txt`
fi
# Extensions:
if [ -f /home/james/final/LlistaExtendions.txt ]
	then
	`rm -rf /home/james/final/LlistaExtensions.txt`
fi

count=0 # Variable per contar usuaris que es creen.
num=1   # Variable per anar enumerant cada usuari.

# Comprobar si es root, si no ho fos no continuem.
if [ `id -u` -ne 0 ] # El ID del usuari que executa el script ha de ser 0, sino no continuem.
	then
		echo "Has de ser root per poder crear usuaris!"
		exit 1
fi

echo "Indica la ruta del fitxer que conté els users:"
read fitxer

# Comrpovem que existeixi el fitxer o que no estigui buit (ocupa més de 0)
if ! [ -s $fitxer ]
# Abans ho teniem en estatic  -->
#if [ -s /home/james/final/users.txt ]
	then
	echo "No existeix el fitxer o esta buit."
	exit 1
fi

# Guardem el contingut del .txt en una variable i canviem espais per "_" per evitar errors.
# El tr ens va molt bè per conseguir-ho fàcilment.
users=`cat $fitxer | tr " " _`
#estatic -->
#users=`cat /home/james/final/users.txt | tr " " _`

# També he vist la possibilitat de fer els departaments dinamics.
# Preguntar al usuari quins departaments té i de allà creant els grups etc.
# He trobat que la millor opció al final era crear jo mateix els departaments
# que en aquest cas son: Marketing, Soporte i Desarrollo.

# Recollim cada camp, recorrem linea a linea el fitxer:
# Agafem variable '$i' i tallem per cada delimitador ';' o el que sigui.
# -f per indicar quina columna després de les separacions agafem.

# Fem un for del fitxer per recorre cada linea i anem agafant valors dins de $i.
for i in $users
do
nom=`echo $i | cut -d';' -f1` #Tallem el nom, la primera part abans del ;
cognoms=`echo $i | cut -d';' -f2` #Els cognoms serán la segona part ;
c1=`echo $i | cut -d';' -f2 | cut -d'_' -f1`
# Per treure el cognom1 tallem el primer ; i agafem els cognoms, després tallem amb _ ja que
# abans hem cambiat els espais per _ i agafem la primera part
c2=`echo $i | cut -d';' -f2 | cut -d'_' -f2` # la segona apart serà el cognom2
dep=`echo $i | cut -d';' -f3` # Tercera part de ; serà el departament
num_ext=`echo $i | cut -d';' -f4` # Quarta el numero d'extensió
data_naix=`echo $i | cut -d';' -f5` # Cinquena la data de naixament
dni=`echo $i | cut -d';' -f6` # Sisena i última part serà el DNI
login=`echo $i | cut -d'_' -f1 | sed  's/;/_/g'`
# El dni l'hem conseguit agafant el nom i el primer cognom de la mateixa manera d'abans
# però hem utilitzat el 'sed' per substituir el ; per _.

echo "Afegint: $num. $nom, $cognoms, $dep, $num_ext, $data_naix, $dni. Amb login: $login"
all=`echo "$nom, $cognoms, $dep, $num_ext, $data_naix, $dni"`

# Comprovem que el departament es un dels 3 que existeixen
if [ $dep != "desarrollo" ] && [ $dep != "marketing" ] && [ $dep != "soporte" ] && [ $dep != "Desarrollo" ] && [ $dep != "Markeing" ] && [ $dep != "Soporte" ]
	then
	echo "Tots els usuaris han de ser de un departament existent (Desarrollo, Marketing o Soporte."
	echo "El usuari '$num $nom' es de '$dep', no existeix."
	echo "Canvii el contingut del fitxer '$fitxer'".
	exit 1
fi


# No he aconseguit comprovar que num_ext son nomes numerics
# len1=$(expr length "$num_ext")
#	if ! [ $num_ext == '^[0-9]+$' ]
#		then
#		echo "Els números de extensió del usuari '$num $nom' es '$num_ext', només pot contenir números."
#		echo "Editi l'arxiu '$fitxer' per poder continuar."
#		exit 1
#fi

# Comprovem que el DNI estigui format per 9 caràcters.
len=$(expr length "$dni")
if ! [ $len -eq 9 ]
	then
	echo " "
	echo "El DNI del user '$num $nom' no és correcte"
	echo "Edita l'archiu' $fitxer' i torna a provar."
	exit 1
fi

# Comrpovem si el user existeix buscant-lo en el arxiu de /etc/passwd:
if grep -qi "^$login:" /etc/passwd
	then
	echo "L'usuari $login ja existeix, cambia el nom per continuar."
	exit 1
fi

echo "Tot correcte, procedim a crear el usuari"
echo " "

#COMRPOVACIONS
#-----------------------------------------------------------------------------------------
#CREACIONS

# Ara fem la automatització en la creació dels usuaris.
# Amb el seu login, la home, la shell, comentari.
# Li posem de contrasenya el seu dni i l'afegim al grup de sudo i del seu departament
useradd $login -m -s /bin/bash -c "Usuari afegit mitjançant un SCRIPT." -p $dni -g $dep -G sudo

# Creem arxiu de credencials
echo "$login $dni" >> /home/$login/TusCredenciales.txt

# Copiem els arxius segons el departament.
# He introduit rutes estatiques perque funcioni amb la meva estructura.
if [ $dep == "Marketing" ] || [ $dep == "marketing" ]
	then 
	`cp /home/james/final/marketing/* /home/$login`
elif [	$dep == "Soporte" ] || [ $dep == "soporte" ]
	then
	`cp /home/james/final/soporte/* /home/$login`
elif [ $dep == "Desarrollo" ] || [$dep == "desarrollo" ]
	then
	`cp /home/james/final/desarrollo/* /home/$login`
fi

# Creem arxiu de text ordenat per departaments:
echo "$dep; $cognoms; $nom; $login; $dni" >> /home/james/final/LlistaDepartament.txt
# Ordenado por departamentos

# Creem arxiu amb totes les extensions telefóniques de cada user:
echo "$cognoms;$nom;$num_ext;$dep" >> /home/james/final/LlistaExtensions.txt

echo "Usuari $num. $login creat satisfactoriament!"
echo "-"

count=$(($count + 1))
num=$(($num + 1))

done

# Ordenem alfabèticament l'arxiu de departaments, així aconseguim que es quedin ordenats per dep.
`sort -o /home/james/final/LlistaDepartament.txt /home/james/final/LlistaDepartament.txt`

echo " "
echo "$count Users afegits."
