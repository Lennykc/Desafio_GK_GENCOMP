~~~sh
#!/bin/bash/
## G_K/script 24.nov.2020
## bwt2.gk $1
## $1 dir ./trim/
arg=$1

## Se crea un archivo lista con todos los elementos .bam del directorio objetivo
ls ${arg}*1.fq > files

## Se crean los directorios de salida
mkdir ./mapeo

while IFS= read line; do
    ## Se guarda la variable del read 2
	line_2=${line%*1_val_1.fq}2_val_2.fq
    
    ## Se guarda la variable de salida
	output=$(echo "$line_2" | grep -Eo "BC-[0-9]{10}")

    ## Se utiliza esta forma de llamar al programa para ahorrar espacio de disco y que utilice RAM para este proceso
	bowtie2 -x ./referencia/ref_index -1 ${line} -2 ${line_2} -p 2  | samtools view -bS | samtools sort > ${output}.bam
    
    ## Se mueven los archivos de salida al correspondiente directorio
    mv ${output}.bam ./mapeo/${output}.bam
    
    ## Print de salida
    echo "Mapeo de ${line} listo"
done < files

## Se eliminan archivos temporales
rm files
~~~