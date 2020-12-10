#!/bin/bash/
## G_K/script 23.nov.2020
## trim_all.gk $1
## $1 dir ./fastq/
arg=$1 #Como argumento se solicita el directorio objetivo

## Se crea un archivo lista con todos los elementos 1.fastq del directorio objetivo
ls ${arg}*1.fastq > files
  
## Se crean los directorios de salida
mkdir ./trim
mkdir ./trim_report
mkdir ./trim_fastqc
  
while IFS= read line; do

    ## Se guarda la variable del read 2
    line_2=${line%*1.fastq}2.fastq
  
    ## Se ejecuta trim_galore con los siguientes parametros: calidad >25 / adaptadores illumina / cortar N / largo permitido >50 / paired / 
    trim_galore --quality 25 --fastqc --illumina --trim-n --length 50 --paired --cores 4 ${line} ${line_2}

    ## Se mueven los archivos generados a los directorios de salida
    mv ${line%*.fastq}.fq ./trim/${line%*.fastq}.fq
    mv ${line_2%*.fastq}.fq ./trim/${line_2%*.fastq}.fq
    mv ${line}_trimming_report.txt ./trim_report/${line}_trimming_report.txt
    mv ${line_2}_trimming_report.txt ./trim_report/${line_2}_trimming_report.txt
    mv ${line%*.fastq}_fastqc.html ./trim_fastqc/${line%*.fastq}_fastqc.html
    mv ${line_2%*.fastq}_fastqc.html ./trim_fastqc/${line_2%*.fastq}_fastqc.html
    mv ${line%*.fastq}_fastqc.zip ./trim_fastqc/${line%*.fastq}_fastqc.zip
    mv ${line_2%*.fastq}_fastqc.zip ./trim_fastqc/${line_2%*.fastq}_fastqc.zip
done < files

## Se eliminan archivos temporales
rm files