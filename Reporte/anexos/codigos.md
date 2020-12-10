# ANEXOS CÓDIGOS
[Volver](../DESAFIO%20GENOMICA%20COMPUTACIONAL.html)
## DESAFIO GENOMICA COMPUTACIONAL ##
<div style="text-align: right">

### GABRIEL KRÜGER CARRASCO ###
### DOCTORADO EN BIOINFORMÁTICA Y BIOLOGÍA DE SISTEMAS ###

</div>

### *Codigos:*

Todos los siguientes codigos se encuentran en el directorio ~/Reporte/anexos/codigos/

Codigo 1. all_fastqc.gk. Ejecuta Fastq y Multiqc
~~~shell 
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
 ~~~

Codigo 2. trim_all.gk. Ejecuta trim-galore
~~~sh
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
~~~

Codigo 3. bwt2.gk. Ejecuta bowtie2 y samstools y crea archivos .bam
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

Codigo 4. stats.gk. Ejecuta samstools y crea archivos con los numeros estadisticos del mapeo
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

Codigo 5. stats.gk. Ejecuta bcftools, vcfutils.pl y seqtk para crear el archivo .fasta con el genoma ensamblado
~~~sh
#!/bin/bash/
## G_K/script 25.nov.2020
## bcf.gk $1
## $1 dir ./mapeo/
arg=$1

## Se crean los directorios de salida
mkdir ./VCF_files
mkdir ./Fasta_finales 

## Se crea un archivo lista con todos los elementos .bam del directorio objetivo
ls ${arg}*.bam > files

while IFS= read line; do
	output=$(echo "$line" | grep -Eo "BC-[0-9]{10}")

    ## Creacion de archivos vcf
	bcftools mpileup -f referencia.fasta ${line} > ${output}.vcf
	## Creacion de archivo fasta consenso
    bcftools call -c ${output}.vcf | vcfutils.pl vcf2fq | seqtk seq -aQ64 -q20 > ${output}.fasta

	## Se mueven los archivos de salida al correspondiente directorio
    mv ${output}.vcf ./VCF_files/${output}.vcf
	mv ${output}.fasta ./Fasta_finales/${output}.fasta
	
    ## echo de salida output
    echo "${output} listo"
done < files
rm files
~~~

Codigo 6. phy.gk. Ejecuta mafft, pangolin y iqtree para alinear las secuencias, identificar SNPs y crear un arbol filogenomico con las secuencias de metatranscriptoma y la referencia.
~~~sh
#!/bin/bash/
## G_K/script 27.nov.2020
## phy.gk $1
arg=$1 #./Fasta_finales/

## Se crean los directorios de salida
mkdir Alineamiento

## Se crean los archivo de compilacion de fasta
touch compilate.fasta

## Se crea un archivo lista con todos los elementos .fasta del directorio objetivo
ls ${arg}*.fasta > files

while IFS= read line; do
	## Se remplaza el encabezado
    input=$(echo "$line" | grep -Eo "BC-[0-9]{10}")
	cat ${line} | sed "s/NC_045512.2/${input}/" > ${input}.fasta2
    ## Se añade al archivo compilado
	cat ${input}.fasta2 >> compilate.fasta
    ## Se elimina el archivo transitorio
    rm ${input}.fasta2
done < files
## Se elimina el archivo temporal
rm files

## Se mueve el archivo de salida al directorio de salida
mv compilate.fasta ./Alineamiento/compilate.fasta

## Cambiamos directorio para generar los archivos
cd ./Alineamiento/

echo "ALINEAMIENTO"
mafft --auto compilate.fasta > alignment.fasta

echo "PANGOLIN"
pangolin compilate.fasta --outfile compilate.csv --write-tree -t 6

echo "IQTREE"
iqtree -s alignment.fasta -nt 6
~~~