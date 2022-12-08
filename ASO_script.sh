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
                RecogerPracticas
            ;;
        
            2) 
                EmpaquetarPracticas
            ;;
        
            3) 
                ObtenerInformacion
            ;;
        
            4)
                echo "Saliendo del programa..."
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
    echo -e "Menú 1 - Programar recogida de prácticas\n"
    echo -n "Asignatura cuyas prácticas desea recoger: "
    read asignatura
    echo -n "Ruta con las cuentas de los alumnos: "
    
    # Validamos la ruta
    
    existeRuta=false
    while [ $existeRuta = false ]
    do
        read rutaCuentas
        if [ ! -d $rutaCuentas ]
        then
            InformeErrores "El directorio $rutaCuentas no existe. Intentalo de nuevo: "
        else
            existeRuta=true
        fi
    done
    
    
    echo -n "Ruta para almacenar prácticas: "
    read rutaPracticas
    # Si no existe se crea un nuevo directorio
    if [ ! -d $rutaPracticas ]
    then
        mkdir $rutaPracticas
    fi
    echo -e "\nSe va a programar la recogida de las prácticas de ASO para mañanana a las 8:00. Origen: $rutaCuentas. Destino: $rutaPracticas"
    echo -n "¿Está de acuerdo? (s/n) "
    read respuesta
    if [ $respuesta = "s" ]
    then
        day=$(date "+%d" --date="-1 days ago")    # Con esta operación le incrementamos en 1 el valor del día
        month=$(date "+%m")
        echo "00 08 $day $month * sh $(pwd)/holapractica.sh $rutaCuentas $rutaPracticas" >> crontabAux 
        crontab crontabAux 
                                                            
    else
        echo "Volviendo al menú principal..."
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
        if [ ! -d $rutaPracticas ]
        then
            InformeErrores "El directorio $rutaPracticas no existe. Intentalo de nuevo: "
        else
            existeRuta=true
        fi
    done
    
    
    echo -e "\nSe van a empaquetar las prácticas de la asignatura ASO presentes en el directorio $rutaPracticas"
    echo -n "¿Estás de acuerdo? (s/n) "
    read respuesta
    if [ $respuesta = "s" ]
    then
        # empaquetar prácticas TODO MAL
        tarname=$asignatura-$(date +%y%m%d-%H%M)
        tar -C $rutaPracticas -cvzf $rutaPracticas/$tarname.tgz     # Cosas que añadir
        if [ $? != 0 ]
        then
            InformeErrores "El directorio no contiene prácticas para empaquetar."
            rm *.tgz
        #Cosas que añadir aquí
        fi
    else
        echo "Volviendo al menú principal..."
    fi
}



# Obtener el tamaño y fecha del fichero

ObtenerInformacion(){
    echo -e "Menú 3 - Obtener tamaño y fecha del fichero\n"
    echo -n "Asignatura sobre la que queremos informacion: "
    read asignatura
    dir=${path_dict["$asignatura"]}
    dirlen=${#dir}
    if [ $dirlen == 0 ]
    then
        InformeErrores "La asignatura $asignatura no existe"
    else
        archivo=$(ls $dir | grep "^$asignatura")
        tamanio=$(stat -c%s "$dir/$file")
        echo "El fichero generado es $archivo y ocupa $tamanio bytes."
    fi
}




# Registrar errores

InformeErrores(){
    echo "$(date +%d-%m-%Y)	$(date +%H:%M)	$1" | tee -a informe-prac.log
}


AccesoMenu


