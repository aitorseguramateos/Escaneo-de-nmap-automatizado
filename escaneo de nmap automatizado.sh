#!/bin/bash

#declaraciÃ³n de colores
#COLOR_DEFECTO = "\e[0m"
#ROJO = "\e[31m"
#AZUL = "\e[36m"


#valorar si es usuario root
if [ $(id -u) -ne 0 ];
then
    echo -e "\e[31m\nSe necesita usuario root para poder ejecutar el script\e[0m\n"
    exit
fi

test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ];
then
    clear
    read -p "Introduzca la ip a escanear --> " ip_adress

    while true;
    do
        echo -e "\n1) Escaneo de puertos ruidoso."
        echo "2) Escaneo de puertos normal."
        echo "3) Escaneo de puertos silencioso"
        echo "4) Escaneo de puertos servicios y versiones"
        echo "5) Salir"

        read -p "Selecciona un mÃ©todo de escaneo: " opc
        case $opc in
            1) echo "Escaneando la ip..." && nmap -p- --open --min-rate 5000 -T5 -sSVC -Pn -n -v $ip_adress > escaneo_ruidoso.txt && echo -e "\e[36m\nReporte guardado en el archivo 'escaeo_ruidoso.txt'.\e[0m\n"
            exit
            ;;
            2) echo "Escaneando la ip..." && nmap -p- --open $ip_adress > escaneo_normal.txt && echo -e "\e[36m\nReporte guardado en el archivo 'escaeo_normal.txt'.\e[0m\n"
            exit
            ;;
            3) echo "Escaneando la ip..." && nmap -p- -T2 -sS -Pn -f $ip_adress > escaneo_silencioso.txt && echo -e "\e[36m\nReporte guardado en el archivo 'escaeo_silencioso.txt'.\e[0m\n"
            exit
            ;;
            4) echo "Escaneando la ip..." && nmap -sS -sV $ip_adress > escaneo_servicios_versiones.txt && echo -e "\e[36m\nReporte guardado en el archivo 'escaeo_servicios_versiones.txt'.\e[0m\n"
            exit
            ;;
            5) echo -e "\e[31m\nHa salido del programa con Ã©xito!\e[0m\n" 
            break 
            ;;
            *) clear && echo -e "\e[31m\nNo se ha introducido una opciÃ³n correcta.\e[0m\n" 
            ;;
        esac
    done
else
    echo -e "\e[31m\n[!] Hay que instalar las dependencias.\e[0m\n" && apt update >/dev/null && apt upbrade -y && apt install nmap && echo -e "\e[36m\nDependencias instaladas con Ã©xito!.\e[0m\n"
fi  