#!/bin/bash



# Hacer una funcion que compruebe la existencia de una ruta ya que la usamos varias veces


# Funciones referidas al menú (MostarMenu y AccesoMenu)

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
}

AccesoMenu(){
    running=true
    while [ $running = true ] 
    do
        MostrarMenu
        read opcion
        case "$opcion" in
            1)
                echo "Programar recogida"
                RecogerPracticas
            ;;
        
            2) 
                echo "Empaquetar prácticas"
                EmpaquetarPracticas
            ;;
        
            3) 
                echo "Ver tamaño"
                ObtenerInformacion
            ;;
        
            4)
                echo "Exit"
                running=false
            ;;
        
            *)
                echo -e "\nLa opción introducida no es válida, introduce una de las mostradas en el menú\n"
            ;;
        esac
    done
}



# Recogida de prácticas

RecogerPracticas(){
    echo -e "Menú 1 - Prgramar recogida de prácticas\m"
    echo -n "Asignatura cuyas prácticas desea recoger: "
    read asignatura
    echo -n "Ruta con las cuentas de los alumnos: "
    existeRuta=false
    while [ $existeRuta = false]
    do
        read rutaCuentas
        if #comprobar si existe
        then
            # Imprime errores
        else
            existeRuta=true
        fi
    done
    echo -n "Ruta para almacenar prácticas: "
    read rutaPracticas
    # Si no existe se crea un nuevo directorio
    if [[ ! -d $rutaPracticas]]
    then
        mkdir $rutaPracticas
    fi
    echo -e "\nSe va a programar la recogida de las prácticas de ASO para mañanana a las 8:00. Origen: bla bla bla. Destino: bla bla bla"
    echo -n "¿Está de acuerdo? (s/n) "
    read respuesta
    if [[ $respuesta = "s"]]
    then
        # Coger prácticas
    fi
}





# Empaquetar prácticas de la asignatura

EmpaquetarPracticas(){
    echo -e "Menú 2 - Empaquetar prácticas de la asignatura\n"
    echo -n "Asignatura cuyas prácticas se desea empaquetar: "
    read asignatura
    echo -n "Ruta absoluta del directorio de prácticas: "
    existeRuta=false
    while [ $existeRuta = false ]
    do
        read rutaPracticas
        if [[ ! -d $path_alumnos ]]
        then
            #error
        else
            existeRuta
        fi
    done
    echo -e "\nSe van a empaquetar las prácticas de la asignatura ASO presentes en el directorio bla bla bla"
    echo -n "¿Estás de acuerdo? (s/n) "
    read respuesta
    if [[ $respuesta == "s" ]]
    then
        # empaquetar prácticas
    fi
}





# Obtener el tamaño y fecha del fichero

ObtenerInformacion(){
    echo -e "Menú 3 - Obtener tamaño y fecha del fichero\n"
    echo -n "Asignatura sobre la que queremos informacion: "
    read asignatura
    echo -e "\nEl fichero generado es bla bla bla y ocupa bla bla bla bytes"
    # Mostrar info
}

# Registrar errores

InformeErrores(){
    echo "bla bla bla en bla bla bla y metiendolo en un archivo llamado informe-prac.log"
}


AccesoMenu
