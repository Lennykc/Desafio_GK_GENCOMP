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