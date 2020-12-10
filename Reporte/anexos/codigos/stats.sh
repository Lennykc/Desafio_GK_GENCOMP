~~~sh
#!/bin/bash/
## G_K/script 24.nov.2020
## stats.gk $1
## $1 dir ./mapeo/
arg=$1

## Se crea un archivo lista con todos los elementos .bam del directorio objetivo
ls ${arg}*.bam > files

## Se crean los directorios de salida
mkdir ./mapeo_stats

while IFS= read line; do
    ## Se guarda la variable de salida
	output=$(echo "$line" | grep -Eo "BC-[0-9]{10}")

	## Se ejecuta samtools stats
    samtools stats ${line} > ${output}_stats.txt
	
    ## Se mueven los archivos de salida al correspondiente directorio
    mv ${output}_stats.txt ./mapeo_stats/${output}_stats.txt
    
    ## Print de salida
    echo "${line} stats listo"
done < files
## Se eliminan archivos temporales
rm files
~~~