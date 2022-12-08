#!/bin/bash

# Funciones referidas al menú e inicio del programa (MostarMenu y IniciarPrograma)

MostrarMenu(){
    echo "\nASO 22/23 - Práctica 6"
    echo "Aruka Cynthia Torres Celorio\n"
    
    echo "Gestión de prácticas"
    echo "--------------------\n"
    
    echo "    1) Programar recogida de prácticas"
    echo "    2) Empaquetado de prácticas de una asignatura"
    echo "    3) Ver tamaño y fecha del fichero de una asignatura"
    echo "    4) Finalizar programa\n"
    echo -n "Elige una opción: "
}

IniciarPrograma(){
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
                echo "\nLa opción introducida no es válida, introduce una de las mostradas en el menú\n"
            ;;
        esac
    done
}



# Recogida de prácticas

RecogerPracticas(){
    echo "Menú 1 - Programar recogida de prácticas\n"
    echo -n "Asignatura cuyas prácticas desea recoger: "
    read asignatura
    echo -n "Ruta con las cuentas de los alumnos: "
    
    # Comprobamos que la ruta dada existe y si no enviamos un error
    
    existeRuta=false
    while [ $existeRuta = false ]
    do
        read rutaCuentas
        if [ ! -d $rutaCuentas ]
        then
            InformeErrores "El directorio $rutaCuentas no existe. Intentalo de nuevo. "
        else
            existeRuta=true
        fi
    done
    
    # Comprobamos que la ruta existe, si no se crea un nuevo directorio
    
    echo -n "Ruta para almacenar prácticas: "
    read rutaPracticas
    if [ ! -d $rutaPracticas ]
    then
        mkdir $rutaPracticas
    fi
    
    echo "\nSe va a programar la recogida de las prácticas de ASO para mañana a las 8:00. Origen: $rutaCuentas. Destino: $rutaPracticas"
    echo -n "¿Está de acuerdo? (s/n) "
    read respuesta
    
    # Programamos la tarea
    
    if [ $respuesta = "s" ]
    then	
        day=$(date "+%d" --date="-1 days ago")    		# Con esta operación le incrementamos en 1 el valor del día
        month=$(date "+%m")
        echo "00 08 $day $month * sh $(pwd)/holapractica.sh $rutaCuentas $rutaPracticas" >> crontabAux 
        crontab crontabAux
	echo "Se ha programado correctamente la recogida de prácticas."
                                                            
    else
        echo "Volviendo al menú principal..."
    fi
}





# Empaquetar prácticas de la asignatura

EmpaquetarPracticas (){
    echo "Menú 2 - Empaquetar prácticas de la asignatura\n"
    echo -n "Asignatura cuyas prácticas se desea empaquetar: "
    read asignatura
    echo -n "Ruta absoluta del directorio de prácticas: "
    
    # Comprobamos que la ruta dada existe y si no enviamos un error
    
    existeRuta=false
    while [ $existeRuta = false ]
    do
        read rutaPracticas
        if [ ! -d $rutaPracticas ]
        then
            InformeErrores "El directorio $rutaPracticas no existe. Intentalo de nuevo. "
        else
            existeRuta=true
        fi
    done

    # Se empaquetan las prácticas

    echo "\nSe van a empaquetar las prácticas de la asignatura ASO presentes en el directorio $rutaPracticas"
    echo -n "¿Estás de acuerdo? (s/n) "
    read respuesta
    if [ $respuesta = "s" ]
    then

		tarname=$asignatura-$(date +%y%m%d-%H%M)
		tar -C $rutaPracticas -cvzf $rutaPracticas/$tarname.tgz $rutaPracticas/*.sh 2>/dev/null
		
		# Se comprueba si en el directorio dado hay prácticas que empaquetar
		
		if [ $? != 0 ]
		then
			InformeErrores "No hay prácticas en el directorio dado"
			rm *.tgz							# Se procede a borrar el archivo creado sin prácticas
		fi
    else
    echo "Volviendo al menú principal..."
    fi
}




# Obtener el tamaño y fecha del fichero

ObtenerInformacion(){
    echo "Menú 3 - Obtener tamaño y fecha del fichero\n"
    echo -n "Asignatura sobre la que queremos informacion: "
    read asignatura
    
    # Obtenemos la ruta del último archivo comprimido que contenga el nombre de la asignatura dada
    
    rutaUltimoArchivo=$(find -type f -iname "*.tgz" | find -iname "$asignatura*" |  tail -n 1)
    
    if [ -z "$rutaUltimoArchivo" ]
    then
        InformeErrores "La asignatura $asignatura no tiene ficheros creados."
    else
    	archivo=$(basename $rutaUltimoArchivo)
        tamanio=$(stat -c%s $rutaUltimoArchivo)
        echo "El último fichero generado es $archivo y ocupa $tamanio bytes."
    fi
    rutaUltimoArchivo=0
}



# Registrar errores

InformeErrores(){
    echo "$(date +%d-%m-%Y)	$(date +%H:%M)	$1" | tee -a informe-prac.log
}


IniciarPrograma


