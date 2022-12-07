#!/bin/bash

MostrarMenu(){
    echo "ASO 22/23 - Práctica 6"
    echo -e "Aruka Cynthia Torres Celorio\n"
    
    echo "Gestión de prácticas"
    echo -e "--------------------\n"
    
    echo "    1) Programar recogida de prácticas"
    echo "    2) Empaquetado de prácticas de una asignatura"
    echo "    3) Ver tamaño y fecha del fichero de una asignatura"
    echo -e "    4) Finalizar programa\n"
    echo -n "Elige una opción: "
    
    read opcion
    
    case "$opcion" in
        1)
            echo "Programar recogida"
        ;;
        
        2) 
            echo "Empaquetar prácticas"
        ;;
        
        3) 
            echo "Ver tamaño"
        ;;
        
        4)
            echo "Exit"
        ;;
        
        *)
            echo "La opción introducida no es válida, introduce una de las mostradas en el menú"
        ;;
    esac
}

MostrarMenu