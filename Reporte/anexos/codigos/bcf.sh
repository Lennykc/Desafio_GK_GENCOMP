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