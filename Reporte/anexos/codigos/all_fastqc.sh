#!/bin/bash/
## all_fastqc.gk $1
## script.gk 23.nov.2020
arg=$1 #Como argumento se solicita el directorio objetivo
  
## Se crea un archivo lista con todos los elementos fastq del directorio objetivo
ls ${arg}*.fastq > files
## Se crea directorio destino
mkdir ./fastqc
  
while IFS= read line; do
    
    ## Ejecuta FastQC
    fastqc ${line}
    
    ## Se mueven los output al directorio de salida
    mv ${line}c.html ./fastqc/${line}c.html
    mv ${line}c.zip ./fastqc/${line}c.zip
  done < files

## Se elimina los archivos temporales
rm files
  
## Se ejecuta MultiQC en el directorio de salida
multiqc ./fastq/