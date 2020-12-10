# DESAFIO GENOMICA COMPUTACIONAL</u>
<div style="text-align: right">

### GABRIEL KRÜGER CARRASCO ###
### DOCTORADO EN BIOINFORMATICA Y BIOLOGIA DE SISTEMAS ###

</div>

## Tabla de contenidos ##

- [INTRODUCCION](#introduccion)
- [METODOLOGIA Y RESULTADOS PRELIMINARES](#metodologia-y-resultados-preliminares)
  * [FLUJO DE TRABAJO](#flujo-de-trabajo)
  * [VISUALIZACION DE CALIDAD Y PROCESAMIENTO DE DATOS](#visualizacion-de-calidad-y-procesamiento-de-datos)
  * [MAPEO DE READS CONTRA REFERENCIA](#mapeo-de-reads-contra-referencia)
  * [ANALISIS FILOGENOMICA](#analisis-filogenomico)
  * [ANALISIS DE COMUNIDAD](#analisis-de-comunidad)
- [RESULTADOS](#resultados)
- [DISCUSIONES](#discusiones)
- [REFERENCIAS](#referencias)
- [ANEXOS](#anexos)



## **INTRODUCCION** ##
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

Las ómicas ayudan a poder entender muchas aristas de la biología, ecología y procesos biológicos que aún no tenemos noción de la inmensidad de información que aún falta por rescatar y poder estudiar, por lo que existen muchas estrategias a distinto nivel y orden de información, pasando desde la genómica, transcriptómica, proteómica y metabolómica para nombrar algunas directamente relacionada con el dogma centrar de la biología molecular. En este trabajo se estudia y analiza la ómica relacionada con la expresión génica, es decir la transcriptómica, pero a nivel de comunidad biológica. Esta estrategia busca evaluar la expresión de genes funcionales de una comunidad biológica a través de una metatranscriptómica, pero en estricto rigor, acotaremos este estudio para evaluar la presencia del virus asociado a la enfermedad covid-19.

El SARS-CoV-2, desde ahora en adelante será nombrado como CoV-2, es un tipo de coronavirus, específicamente beta-coronavirus, de hebra simple de ARN que actualmente ha dejado estragos en la salud pública mundial desde inicios del 2020 declarándose epidemia el 30 de enero del 2020 y solo un poco más de dos meses Pandemia. Por lo que evaluar la presencia del virus en entornos urbanos mediante metatranscriptómica, al ser un virus que su material genético está conformado por ARN esta estrategia permitirá secuenciar y detectar su presencia en el ambiente.
Como estudiantes del Doctorado en Bioinformática y Biología de Sistemas participamos voluntariamente en este desafío que pone aprueba nuestros conocimientos y límites para nuestra formación como futuros investigadores.

Como objetivo del desafío nos propusieron el análisis de 20 metatranscriptómica de origen urbano del Gran Santiago, el cual debemos dar como reporte a las siguientes preguntas:

- ¿Podemos detectar CoV-2 en las muestras?
- ¿Podemos reconstruir los genomas? (asociado al virus)
- ¿Podemos detectar a que linaje pertenecen?
- ¿Dónde abundan, que variantes de CoV-2? (En que superficie y zona de la ciudad)
- ¿Hay alguna correlación geográfica con respecto al CoV-2 detectado?

De esta forma elaborar un reporte con la metodología, resultados y discusiones.

* * *

## **METODOLOGIA Y RESULTADOS PRELIMINARES** ##
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

Inicialmente, para el trabajo posterior, se indago en la metadata entregadas junto a las muestras de metatranscriptoma esta se simplifico extrayendo los datos que son útiles que correspondían a las muestras entregadas y así responder a las preguntas asociadas con el desafío. Un resumen se puede observar en la tabla 1.

<center>

 **Tabla 1. Metadata asociada a cada muestras**. Estableciendo la fecha, comuna de muestreo, zona de muestreo, elemento muestreado.


 | **Muestra**     | **Fecha**  | **Comuna**     | **Sitio**                                 | **Especimen**      | **Tipo de Superficie** |
 | --------------- | ---------- | -------------- | ----------------------------------------- | ------------------ |------------------------|
 | *BC-0345795864* | 2020-05-05 | La Florida     | Metro Vicuña Mackena                      | Escalator handrail | Caucho
 | *BC-0345795896* | 2020-05-04 | Ñuñoa          | PD335-Parada 1 / (M)                      | Seat               | Metal
 | *BC-0345797312* | 2020-04-13 | Puente Alto    | Farmacia solidaria Plaza de Puente Alto   | Handrail           | Metal
 | *BC-0345797317* | 2020-04-20 | Ñuñoa          | Walmart                                   | Handrail           | Metal
 | *BC-0345797602* | 2020-04-27 | Ñuñoa          | Walmart                                   | Handrail           | Metal
 | *BC-0345797632* | 2020-04-27 | Puente Alto    | PF176-Parada 3 / (M) Plaza De Puente Alto | Horizontal pole    | Metal
 | *BC-0345797636* | 2020-04-13 | Ñuñoa          | PD335-Parada 1 / (M)                      | Horizontal pole    | Metal
 | *BC-0345797641* | 2020-04-13 | Ñuñoa          | Walmart                                   | Handrail           | Metal
 | *BC-0345797645* | 2020-04-18 | *Home* (Ñuñoa) | *Home* (Control)                          | Control            | Desconocido
 | *BC-0345797686* | 2020-04-27 | Ñuñoa          | PD335-Parada 1 / (M)                      | Seat               | Metal
 | *BC-0345797802* | 2020-04-20 | Ñuñoa          | Santander Bank                            | ATM                | Metal
 | *BC-0345797815* | 2020-04-27 | La Florida     | Metro Bellavista de la Florida            | ATM                | Metal
 | *BC-0345797817* | 2020-04-13 | La Florida     | Metro Bellavista de la Florida            | ATM                | Metal
 | *BC-0345797839* | 2020-04-20 | La Florida     | Metro Vicuña Mackenna                     | Escalator handrail | Caucho
 | *BC-0345798087* | 2020-05-05 | La Florida     | Metro Bellavista de la Florida            | ATM                | Metal
 | *BC-0345798943* | 2020-04-20 | La Florida     | PE1262-Parada 5 / (M)                     | Information board  | Metal
 | *BC-0345799013* | 2020-04-27 | Puenta Alto    | PF512-Parada 2 / (M)                      | Horizontal pole    | Metal
 | *BC-0361053718* | 2020-04-27 | Macul          | PD64-Parada 1 / Colegio San Marcos        | Pole               | Metal
 | *BC-0361053744* | 2020-04-20 | Ñuñoa          | Medical Center                            | Door handle        | Metal
 | *BC-0361057091* | 2020-04-29 | Ñuñoa          | Medical Center                            | Door handle        | Metal

</center>


Los archivos de las muestras se almacenaron en un directorio exclusivo en un disco de 1TB denominado <i>e:</i> en el directorio <i>/mnt/e/Desafio_Genomica/muestras/</i> en cambio la metadata en <i>/mnt/e/Desafio_Genomica/informacion/</i>. Se establece el directorio de trabajo como <i>/mnt/e/Desafio_Genomica/</i> para la ejecución de todos los script que se utilizaran.


### **FLUJO DE TRABAJO** ###
[Volver a Tabla de Contenidos](#tabla-de-contenidos)


El flujo de trabajo para analizar toda esta informacion (Figura 1.) inicia con el análisis de calidad de las secuencias, para determinar los parámetros de corte y filtro mediante trimming, para posteriormente dividir la línea de análisis en una global y otra directa, la línea global abarcara la diversidad taxonómica y observar de forma visual, no funcional pero complementaria. En cambio la directa irá a mapear las reads contra el genoma de referencia para CoV-2. Finalizando con un análisis de profundidad, cobertura para determinar mediante consenso en las muestras, el linaje que pertenece mediante pangolín y GISAID, graficando finalmente con llama los SPNs asociados a los linaje.
Para concluir, se sumaron las muestras de infectados en las fechas tempranas de la pandemia trabajadas en prácticos anteriores para visualizar el mapa de CoV-2 de Santiago en árbol filogenético y en un mapa de la ciudad con la muestras trabajadas.

<center>

![IMAGEN](figuras/WorkFlow.png)

</center>


**Figura 1. Flujo de Trabajo realizado para llevar a cabo el desafío.** Se dividió en 4 grandes secciones. En celeste la visualización de la calidad de la secuenciación, en violeta el mapeo y ensamble según el genoma de referencia, en verde el análisis de la búsqueda de linaje y creación de árbol filogenético con las muestras de Santiago y en naranjo el análisis de diversidad y cuantificación de la comunidad del microbioma urbano.

Los programas utilizados y su versión se adjuntan en la tabla 2. El trabajo se dividió en varias plataformas siendo la más utilizada Unix mediante consola en Ubuntu 20.04 LTS, seguida de Python v3.8.5 mediante interfaz grafica de anaconda por medio de Jupyter-Lab v2.2.6.

</div>
<center>

**Tabla 2. Paquetes utilizados en durante el Desafío**

 | **Paquete**   | **Versión** | **Workflow**            |
 | ------------- | ----------- | ----------------------- |
 | fastQC        | v0.11.9     | Calidad y Procesamiento |
 | MultiQC       | v1.9        | Calidad y Procesamiento |
 | Trim_Galore   | v0.6.6      | Calidad y Procesamiento |
 | Bowtie2       | v2.3.5.1    | Mapeo y Ensamble        |
 | Samtools      | v1.11       | Mapeo y Ensamble        |
 | Bcftools      | v1.11       | Mapeo y Ensamble        |
 | Seqtk         | v1.3-r106   | Mapeo y Ensamble        |
 | Mafft         | v7.475      | Filogenomica            |
 | IQ-Tree       | v1.6.12     | Filogenomica            |
 | Pangolin      | v1.1.14     | Filogenomica            |
 | Llama         | v0.1        | Filogenomica            |
 | BEAST         | v1.10.4     | Filogenomica            |
 | BEAUti        | v1.10.4     | Filogenomica            |
 | TreeAnnotator | v1.10.4     | Filogenomica            |
 | TRACER        | v1.7.1      | Filogenomica            |
 | FigTree       | v1.4.4      | Filogenomica            |

</center>


 ### **VISUALIZACION DE CALIDAD Y PROCESAMIENTO DE DATOS** ###
 [Volver a Tabla de Contenidos](#tabla-de-contenidos)

 Los datos de metatranscriptómica de las 20 muestras fueron analizados con FastQC mediante consola para generar un reporte con el programa Multiqc, como se explica en el siguiente código.

<details>
<summary>
<i> Codigo fastqc </i>
</summary>
<p>

 ~~~console
 (fastqc)foo@bar:/mnt/e/Desafio_Genomica$ bash all_fastqc.gk ./muestras/
 ~~~
 
 Cuyo script es el siguiente.
 
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

</p>
</details>

Este pequeño código a medida que se va ejecutando FastQC va ordenando el directorio como corresponde para evitar perdidas de archivos y acumulación de estos. Al finalizar el bucle while se ejecuta MultiQC para generar un reporte masivo entre todos los análisis de las muestras.

<div style="text-align: right"> 

 **El reporte se muestra acontinuacion <i> [MULTIQC REPORT](multiqc/multiqc_report.html)** </i>

</div>

Del reporte se puede rescatar la magnitud de cantidad de reads que van desde 21.7 Millones hasta 34.0 Millones, también la calidad de secuenciación de promedio sobre 28 <i>Phred Score</i> lo que promete rescatar muy buena información al tener que cortar solo los adaptadores y no tomar encuentra que se perderá información al filtrar por calidad. En cambio, un estadístico que llamo mucho la atención es la cantidad de reads duplicados, desde un 80.2 a 96.5% haciendo inferir una baja diversidad en la comunidad del microbioma.

 El siguiente paso para depurar las muestras es aplicar trimming para cortar y filtrar las reads, quitando los adaptadores y evaluando su calidad para quedar con aquellas que  superen el umbral designado.

 Para ello aplicamos el siguiente código en bash.

<details>
<summary>
<i> Codigo trim Galore </i>
</summary>
<p>

 ~~~console
  (trim-galore)foo@bar:/mnt/e/Desafio_Genomica$ bash trim_all.gk ./muestras/
 ~~~
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

</p>
</details>

Una ves terminado el programa Trim_Galore, se procese a ejecutar MultiQC en el directorio /trim_fasqc/ como muestra el siguiente código.

<details>
<summary>
<i> Codigo multiqc trim </i>
</summary>
<p>

~~~console
 (fasqc)foo@bar:/mnt/e/Desafio_Genomica$ multiqc ./trim_fastqc/
~~~

</p>
</details>

<div style="text-align: right"> 

 **El reporte se muestra acontinuacion <i> [TRIM MULTIQC REPORT](trim_multiqc/multiqc_report.html)** </i>

</div>

Corroborando la eliminación de todos los adaptadores de las reads y que la mayoría del resto de los estadísticos se mantuvieron relativamente estáticos o con poca variación. Con este preprocesamiento de las reads, se puede trabajar con el mapeo y análisis de diversidad como siguiente parte del flujo de trabajo.

### **MAPEO DE READS CONTRA REFERENCIA** ###
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

El programa para realizar el mapeo es bowtie2, el cual necesita indexar una referencia para poder realizar el mapeo. El genoma de referencia se descarga desde NCBI, este genoma de CoV-2 es utilizada para los estudios genómicos asociados al virus. NC_045512.2 es el genoma que hace referencia al caso 0, asilada desde un paciente desde fluidos de lavado broncoalveolar documentado el 2020-12-30.

Para crear el índice de referencia se ejecuta el siguiente código.

<details>
<summary>
<i> Codigo bowtie2 referencia index </i>
</summary>
<p>

~~~console
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica$ mkdir ./referencia/
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica$ cd ./referencia/
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica/referencia/$ bowtie2-build NC_045512.2_ref.fasta ref_index
~~~

</p>
</details>

Estos archivos creados por el programa son necesarios para que se logre el mapeo de todas las reads y puedan ser anotadas para su posterior análisis y ensamble.

Se ejecuta bowtie2 en un script, como detallo a continuación.

<details>
<summary>
<i> Codigo bowtie2 mapeo </i>
</summary>
<p>

~~~console
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica/referencia/$ cd ..
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica$ bash bwt2.gk ./trim/
~~~
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

</p>
</details>

Terminado el mapeo se puede obtener las estadísticas de este con la parámetro *stats* de samtools.

<details>
<summary>
<i> Codigo samtools stats </i>
</summary>
<p>

~~~console
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica$ bash stats.gk ./mapeo/
~~~

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

</p>
</details>

De estos informes de estadísticas **(Anexo *[Stats](anexos/stats.html)*)** se puede observar parámetros por ejemplo de mapeo y cobertura del genoma, en este caso, de CoV-2.
Seguido del análisis de las estadísticas entregadas por samtools, se prosiguió a la generación de los archivos vcf para complementar el análisis de cobertura y profundidad de mapeo, detectando así cada cambio que tiene las reads mapeadas con la referencia, en el mismo script se generan los archivos fastas consenso para el próximo análisis. Esto se logro gracias el programa bcftools que fue ejecutado mediante el siguiente script.

<details>
<summary>
<i> Codigo bcftools</i>
</summary>
<p>

~~~console
  (bwt2)foo@bar:/mnt/e/Desafio_Genomica$ bash bcf.gk ./mapeo/
~~~

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

</p>
</details>

Con los archivos .vcf podemos observar todos los SNPs presentes en cada muestra y poder determinar junto con los análisis filogenéticos los SNPs correspondientes a las variantes detectadas por los programas como pangolin y llama observando la profundidad de secuenciación obtenida para cada muestreo.

### **ANALISIS FILOGENOMICO** ###
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

El análisis filogenómico se hace en base a los archivos .fasta entregado por el script bcftools, con ellos se realiza una concatenación entre todos los fasta para generar un compilado de secuencias ensambladas y se realiza un alineamiento multiple con mafft, para posteriormente construir un árbol global con iqtree y analizar las variantes con pangolin, como se detalla a continuación en el siguiente código.

<details>
<summary>
<i> Codigo alineamiento, arbol y deteccion de variantes</i>
</summary>
<p>

~~~console
(mafft)foo@bar:/mnt/e/Desafio_Genomica$ bash phy.gk ./Fasta_finales/
~~~

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

</p>
</details>

Se modifican los nombres de salida de algunos archivos de forma manual a metadata.csv y global.tree para que el programa *llama* pueda funcionar correctamente. De esta forma ejecutamos el siguiente código en el directorio de *./Alineamiento*

<details>
<summary>
<i> Codigo llama </i>
</summary>
<p>

~~~console
(llama)foo@bar:/mnt/e/Desafio_Genomica$ cd ./Alimneamiento
(llama)foo@bar:/mnt/e/Desafio_Genomica/Alimneamiento$ llama -i metadata.csv -f alignment.fasta -d ./ --data-column name --lineage-representatives --number-of-representatives 7
~~~

</p>
</details>

Pangolin finalmente entregara una metadata asociada a la variante encontrada la cual se añadirá a la metadata general de trabajo como linaje. Para determinar el clado se trabaja con la plataforma online de [GISAID](https://www.gisaid.org/epiflu-applications/covsurver-mutations-app/), subimos el archivo *compilate.fasta* y el resultado sera agregado a la metadata de trabajo como clado.

Llama entregara información sobre los SNPs, mediante una infografía resumida [Resultados]() donde podemos identificar cada SNPs y compararlos con los archivos .vcf para mejorar el análisis de los SNPs.

Finalmente, los datos vistos en el practico de filogenia de Genómica Computacional y se extraen datos y genomas de las muestras de Santiago, Chile. Para ello se toman los mismos parámetros de la metadata de trabajo y se concatena la metadata y los genomas en dos archivos, en metadata_cov.tsv (*[Anexos metadatas](./anexos/metadata.html)* y en )compilado_cov.fasta (*[Anexos secuencias](./anexos/secuencia.html)*). Con estos archivos se procede a crear un archivo .xml en BEAUti con los tips de anotación de las fechas de muestreo incorporando la metadata, se utiliza un prior de crecimiento exponencial con taza de crecimiento y random tree, se deja los tree prior en default y las iteraciones se establecen en 500 millones con generación de log parameter cada 1000. Con el archivo .xml se ejecuta BEAST y luego de que termine sus iteraciones se revisaron sus parámetros con TRACER y cerciorar que los indicadores estadísticos estén correctos se elige el árbol con los mayores indices para importarle la metada y poder observar la distribución de las muestras junto a las muestras de Santiago.

* * *

## **RESULTADOS** ###
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

De las muestras de metatranscriptómica fue posible mapear contra el genoma de referencia NC_045512.2 en cada muestra entregada, por lo que si fue posible detectar CoV-2. Esto fue posible observar en los datos estadísticos que muestra samtools después de ejecutar bowtie2. En la tabla 3 nos arrojo datos esperados, al ser una metatranscriptómica y observar la magnitud de reads repetidos, los porcentajes de reads mapeados no superan el 1.15% del total de reads secuenciados, con un valor mínimo de 0,00085% en la muestra BC-0345795896. En la cobertura contra el genoma de referencia, algunas muestras lograron mapear hasta 2832x veces el genoma, rondando en valores generalmente entre 14 y 92x.
Valores que permitieron reconstruir el genoma hasta sobre 95.5% llegando a valores ~99.9% [Anexo Mapa de Coberturas](./Anexo/Mapa.html), las muestras que tienen una cobertura entre ~2 y ~6 no alcanzan un 90% de completitud. En conclusion, fue posible detectar y reconstruir el genoma de CoV-2 en las muestras urbanas de Santiago. Se tomaran encuentra aquellos genomas clasificados por GISAID como Completos de normal y alta cobertura para los siguientes análisis.

<center>

**Tabla 3. Análisis de estadísticos de cobertura y completitud del genoma.** Proporción de reads mapeados contra los totales, cobertura de respecto al genoma de referencia y calidad de la reconstrucción del genoma.\*


 | **Muestra**       | **Reads Totales** | **Read Mapeados** | **Porcentajes de reads mapeados** | **Bases mapeadas** | **Cobertura** | **Profundidad Promedio** | **N%**   | **Genoma\[pb\]** | **Status GISAID\*\***       |
 | ----------------- | ----------------- | ----------------- | --------------------------------- | ------------------ | ------------- | ------------------------ | -------- | ---------------- | --------------------------- |
 | *BC-0345795864*   | 52'628'798          | 1'319              | 0,0025%                           | 186'064             | 6,4153x       | 6.2207x                  | 10.1503% | 26839            | Incompleto baja covertura   |
 | *BC-0345795896*   | 57'451'448          | 490               | 8,5e-4%                           | 67'101              | 2,3135x       | 2.2429x                  | 35.7992% | 19171            | Incompleto baja covertura   |
 | *BC-0345797312*   | 59'128'090          | 838               | 0,0014%                           | 116'308             | 4,0102x       | 3.8891x                  | 18.2344% | 24416            | Incompleto baja covertura   |
 | *BC-0345797317*   | 63'805'850          | 965               | 0,0015%                           | 131'525             | 4,5348x       | 4.3975x                  | 18.3105% | 24399            | Incompleto baja covertura   |
 | *BC-0345797602*   | 67'748'216          | 1'856              | 0,0027%                           | 262'640             | 9,0556x       | 8.7809x                  | 4.41304% | 28548            | Incompleto covertura normal |
 | **BC-0345797632** | 64'008'202          | 8'224              | 0,0128%                           | 1'173'429            | 40,458x       | 39.229x                  | 0.17742% | 29818            | Completo  alta covertura    |
 | **BC-0345797636** | 66'723'700          | 2'902              | 0,0043%                           | 407'785             | 14,060x       | 13.634x                  | 1.05788% | 29555            | Completo covertura normal   |
 | **BC-0345797641** | 63'171'532          | 9'150              | 0,0144%                           | 1'344'597            | 46,360x       | 44.951x                  | 0.06695% | 29852            | Completo alta covertura     |
 | **BC-0345797645** | 48'683'998          | 558'306            | 1,1467%                           | 82'148'765           | 2'832,4x       | 2'656.5x                  | 0.06025% | 29853            | Completo alta covertura     |
 | *BC-0345797686*   | 64'567'526          | 754               | 0,0011%                           | 105'141             | 3,6251x       | 3.5159x                  | 19.7482% | 23972            | Incompleto baja covertura   |
 | **BC-0345797802** | 42'943'176          | 147'182            | 0.3427%                           | 21'029'289           | 725,07x       | 703.12x                  | 0.04352% | 29858            | Completo alta covertura     |
 | **BC-0345797815** | 54'277'256          | 10'390             | 0,0191%                           | 1'503'965            | 51,855x       | 50.284x                  | 0.12721% | 29833            | Completo alta covertura     |
 | **BC-0345797817** | 60'955'410          | 18'895             | 0,0309%                           | 2'694'216            | 92,894x       | 90.078x                  | 0.05691% | 29854            | Completo alta covertura     |
 | **BC-0345797839** | 64'648'716          | 8'557              | 0,0132%                           | 1'230'510            | 42,426x       | 41.137x                  | 0.06695% | 29851            | Completo alta covertura     |
 | **BC-0345798087** | 49'684'946          | 4'681              | 0,0094%                           | 661'285             | 22,800x       | 22.111x                  | 0.32138% | 29775            | Completo alta covertura     |
 | **BC-0345798943** | 60'875'176          | 3'441              | 0,0056%                           | 492'162             | 19,969x       | 16.452x                  | 1.69060% | 29366            | Completo covertura normal   |
 | **BC-0345799013** | 64'266'166          | 11'222             | 0,0174%                           | 1'596'999            | 55,063x       | 53.398x                  | 0.03682% | 29860            | Completo alta covertura     |
 | **BC-0361053718** | 56'723'540          | 10'253             | 0,0180%                           | 1'478'615            | 50,981x       | 49.434x                  | 0.18079% | 29814            | Completo alta covertura     |
 | **BC-0361053744** | 59'184'074          | 37'031             | 0,0625%                           | 5'417'400            | 189,78x       | 181.11x                  | 0.04351% | 29859            | Completo alta covertura     |
 | **BC-0361057091** | 58'409'500          | 36'843             | 0,0630%                           | 5'350'695            | 184.48x       | 178.90x                  | 0.58250% | 29697            | Completo alta covertura     |
</center>

\* Muestras en negritas: Genomas seleccionados para siguientes ensayos.

\*\*[Parámetros establecidos por GISAID para determinar el cumplimiento de calidad de un genoma de CoV-2](www.gisaid.org)


De 20 muestras se filtraron a 14, es con estas ultimas que se realiza el análisis filogenómico contra la referencia, utilizando pangolin, llama y la base de datos de GISAID determinando linaje y clado al que pertenecen el CoV-2 asociado a cada muestra. La tabla 4 resume los resultados obtenidos para cada muestra, destacando que pangolin y llama detectaron los SNPs asociado al linaje B.1 para todas las muestras. En cambio, la base de datas de GISAID asoció para la mayoría de las muestras al clado GH, exceptuando 4 muestras (BC-0345797636, BC-0345797641, BC-0345797839 y BC-0345798087). GISAID asocia SNPs específicos y reportados para asignar una variante, por lo que incluyendo sus estadísticos, GISAID no asocio un clado a estas muestras, muy posiblemente al encontrar regiones de N en el genoma.

<center>

**Tabla 4. Asignacion de linaje y clado de los genomas seleccionados.**


 | **Muestra**     | **Linaje** | **Clado** |
 | --------------- | ---------- | --------- |
 | *BC-0345797632* | B.1        | GH        |
 | *BC-0345797636* | B.1        | OTHER     |
 | *BC-0345797641* | B.1        | OTHER     |
 | *BC-0345797645* | B.1        | GH        |
 | *BC-0345797802* | B.1        | GH        |
 | *BC-0345797815* | B.1        | GH        |
 | *BC-0345797817* | B.1        | GH        |
 | *BC-0345797839* | B.1        | OTHER     |
 | *BC-0345798087* | B.1        | OTHER     |
 | *BC-0345798943* | B.1        | GH        |
 | *BC-0345799013* | B.1        | GH        |
 | *BC-0361053718* | B.1        | GH        |
 | *BC-0361053744* | B.1        | GH        |
 | *BC-0361057091* | B.1        | GH        |

</center>

Con la generación de una tabla complementada con los datos obtenidos de cobertura, profundidad y completitud del genoma se puede observar y caracterizar la abundancia y que superficies esta mas presente CoV-2. En la Tabla completa [Anexo Tabla metadata utilizada]() se compilo toda la información recolectada, pudiendo determinar que la superficie donde se presenta mas CoV-2 es la metálica, de esta destacan los cajeros automáticos (ATM) y manillas de puerta.

Finalmente, .... comunidades microbianas


## **DISCUSIONES** ##
[Volver a Tabla de Contenidos](#tabla-de-contenidos)


La información levantada desde estos metatranscriptómicas son esenciales para el entendimiento y comportamiento del virus CoV-2 en el ambiente urbano, siendo en la técnica no del todo eficiente, ya que el virus en un ambiente no de hospedero no posee metabolismo, por lo que la técnica de transcriptómica no esta siendo utilizada para la finalidad de detectar expresión o genes como normalmente es usada, si no que en este caso esta siendo usada para detectar un genoma viral de ARN que esta en la posibilidad de estar latente en el ambiente, es por esto que se necesita una capacidad no menor de secuenciación con una muy buena profundidad de secuenciación para poder alcanzar a detectarlo. Y es ahi donde llegamos a la respuesta de la primera pregunta ***¿Podemos detectar CoV-2 en las muestras?*** ¿Es capaz la técnica de detectar CoV-2?, para esta pregunta hay que ser estricto en la respuesta, personalmente esta respuesta recae en opciones binarias, *Si* o *No*. Algunas muestras provenientes de sitios donde no hay mucho contacto piel-superficie, por ejemplo, los asientos de paradero, existe menor probabilidad de contacto directo en la superficie para impregnar con el virus. Justamente en esas muestras existe una menor cantidad de lecturas que mapean contra el genoma de referencia, llegando a tener una cobertura y profundidad de aproximadamente 2 a 3x pudiéndose considerar un posible artefacto si es que se tuviera un control ideal para poder descartarlo. Es en este punto donde entra la complejidad de asignar o no la acción de detección, principalmente en poder contestar las siguientes dos preguntas, si es posible reconstruir el genoma e identificar el linaje. Como estos metatranscriptomas no cuentan con un control libre de virus, no queda opción de responder a la primera pregunta con un <u>**SI** se pudo detectar CoV-2 en las muestras</u> (Anotación en Tabla 3) pero no es posible garantizar ni precisar o descartar que tipo de CoV-2 es en aquellas muestras de baja cobertura o si estamos presente a un artefacto en dichos objetos de estudio.

Con una vision un poco mas epidemiológica, la reconstrucción e identificación del linaje de CoV-2 asociado a las muestras debe tomar exigencia para saber fehacientemente si los datos recopilados por el mapeo son considerados buenos para poder evaluar correctamente a las muestras, es por esto que se basa este criterio en lo que considera *"un genoma reconstruido"* por GISAID, quien se encarga de asignar clados y evalúa la integridad de un genoma de CoV-2. GISAID considera un genoma completo a aquel que mínimo contenga mas de 29'000 pb (sin contar Ns) y sea tenga menos de un 1,0 % de Ns, además consideran un estándar de bajo, normal y alta cobertura del genoma, precisando aquellos genomas de alta cobertura que cumplan con < 1,0% de Ns y sin indels, aquellos genomas con baja cobertura que están sobre el 5% de Ns. Con estos estándares cumplieron 14 de 20 secuencias de CoV-2, siendo descartadas el resto para los análisis filogenómicos. De esta manera es <u>**SI** fue posible reconstruir los genomas</u> con un estándar considerablemente bueno, ~0,04% < Ns > ~4,4% (12 Genomas completos de alta cobertura), teniendo confianza de estos datos se determino linaje y clado al que pertenecen las secuencias, mediante pangolin, llama y GISAID.

Pangolin asigno a todas las muestras como la variante B.1, teniendo como datos de tiempo de aparición entre finales de enero y principios de mayo, con paises mas comunes como Reino Unido, Estados Unidos y Australia, siendo la cepa mas común en Europa y la que corresponde al brote de Italia, teniendo una correlación lógica a la información de los primeros casos confirmados que llegaron a Santiago, personas con antecedentes de venir de viajes de Europa y principalmente de Italia, que termino siendo propagado por la ciudad y provocando el brote de esta variante.

Junto con Llama se identificaron los SNPs asociado a las variantes, de estas se asociaron en total 9 SNPs apreciándose en la figura 2, destacando 2 SNPs en el marco de lectura de que codifica para la proteína S (Tabla 5), 1 en el marco abierto de lectura para la proteína no-estructural 3 (NS3) y para 8 (NS8) y 5 SNPs asociado al ORF1ab.
Al ir al detalle de cada uno de los SNPs, resalta a la luz que en contraste con lo referenciado en los archivos .VCF [Anexo archivos VCF]() algunos SNPs anotados por pangolin y llama tienen una profundidad relativamente baja, por ejemplo, el SNPs de la muestra **BC-0345797636** en la posición 22248, que es la única muestra que lo posee, tiene una profundidad de secuenciación de 4 y cambia un T por A al codon T**T**G para leucina por un codo T**A**G que corresponde a un stop, para llegar a corroborar este SNPs habría que secuenciar al espécimen (siendo imposible) o que la secuenciación tenga mayor profundidad en ese SNPs. Por lo que lo que representa llama en su infografía hay que corroborarlo manualmente para poder discernir objetivamente que dichos SNPs tengan al menos un valor mayor o igual al promedio de la profundidad obtenida para cada muestra.

En cambio, GISAID utiliza su bases de datos para determinar SNPs y asignar uno de los 7 clados con los que clasifica CoV-2. Segun su clasificación todos le asigno el clado **GH** a excepción de 4 genomas que asigno como **OTHER** que en sucesion son los 4 con menor profundidad y cobertura de secuenciación (~13 a ~41x de profundidad). Por lo que en respuesta de que si es posible determinar linaje, **SI** es posible determinar linaje, pero dependiendo de las calidades de secuenciación como profundidad y cobertura si no son los adecuados puede generar malas interpretaciones, por lo que es necesario un depurado y tener la exigencia en vincular correctamente los datos generados por bcftools, pangolin y llama para generar una conclusion correcta en la asignación de los SNPs y asociarlo con el linaje correspondiente.
 

<center>

![IMAGEN](figuras/llama.png)



**Figura 2. Infografía resultado de Llama.** Las muestras están anotadas a la derecha, las posiciones de los SNPs detectados en la parte superior, la referencia se muestra en la parte inferior representado a la posición del genoma. Los nucleótidos **A**, **C**, **T**, **G** se representan en colores azul, rojo, verde celeste, en cambio **R** e **Y** en gris anotándose solo aquellas diferencias contra la referencia. En total fueron detectados 9 SNPs en conjunto con todos los datos.

**TABLA 5. SNPs de muestras contra la referencia.** Gen afectado y nombre de la proteína
POSICION | GEN  | PROTEINA 
---------|------|----------|
1059 | *ORF1ab* | NSP2 
3037 | *ORF1ab* | NSP3
8782 | *ORF1ab* | NSP4
14408 | *ORF1ab* | RNA-POL DEP-RNA
18877 | *ORF1ab* | 3'-5'EXONUCLEASA
22248 | *S* | Glicoroteina Spike 
23403 | *S* | Glicoroteina Spike 
25563 | *ORF3* | NS3
28144 | *ORF8* | NS8

</center>

En contraparte, para poder visualizar la distancia evolutiva de las muestras con respecto al resto de las de Santiago al principio del pandemia se construyo un árbol filogenómico incluyendo las muestras de los metatranscriptomas que lograron los estándares de determinar la reconstrucción del genoma y clasificarlos al linaje correspondiente.
Todas las muestras se agrupan en el clado correspondiente al GH por GISAID, incluyendo una muestra de Santiago (ID GISAID). El clado formado se agrupa entre los que corresponden a GR y G, bien delimitados lo que estaría explicando como este se le atribuye la variante designada. Además, es posible rescatar la información temporal pudiendo correlacionar fechas de aparición de las variante, que se explicara mas en detallas posteriormente.

<center>

**Figura 3. Representación de árbol filogenómico de CoV-2 de muestras de metatranscriptómica junto con muestras GISAID de Santiago 03-2020/04-2020**.(Descripcion de colores)

![IMAGEN](figuras/phy_tree.png)

</center>

Analizando finalmente las 10 muestras restantes (Aquellas de genomas completos e identificando y cerciorando clado y linaje), se pueden asociar ahora con la metadata compilada expuesta en la tabla 6 [Anexo Metadata Tabla con todas las muestras](dir). Con ello podemos identificar aquellas muestras donde abundan, que superficie y sitio donde se encuentran presente. Se puede observar que el virus se encuentran todos en superficies metálicas, salvo la muestra *BC-0345797645* el cual no se tiene algún tipo de información asociada al espécimen y tipo de superficie que fue extraída la muestra asociándola como tipo control. Tambien es posible rescatar que aquellas zonas de interior como lo es el banco (*BC-0345797802*) y centro medico (*BC-0361053744* y *BC-0361057091*) poseen una profundidad promedio de secuenciación sobre los 180x muy probablemente a que el cajero y las manillas de puerta se encontraran en un ambiente libre de radiación y a una temperatura optima para el virus. En cambio, el resto de las muestras que se encuentra en superficie y en subterránea o están expuestos a la radiación  solar (superficie) o altas temperaturas lo que provocaría que el CoV-2 no sobreviera mucho a esa exposiciones reduciendo su presencia en la muestra. Las características de que el virus sobrevive y se transmite mejor con ciertos contactos a tipos de superficie, humedad, temperatura y tiempo antes de llegar al hospedero humano ha sido reportado ([Xue X., et al 2020](https://doi.org/10.1016/j.matt.2020.10.006), [Chin A.W.H., et al 2020](https://doi.org/10.1016/S2666-5247(20)30003-3), [Santarpia J.L., 2020](https://doi.org/10.1038/s41598-020-69286-3)), coincidiendo con las características reportadas.


<center>

**Tabla 6. Compilado de las muestras seleccionadas.**

 | **Muestra**     | **Fecha**  | **Comuna**     | **Sitio**                                 | **Especimen**      | **Tipo de Superficie** | **Cobertura** | **Profundidad Promedio** | **Status GISAID** | **Linaje** | **Clado** |
 | --------------- | ---------- | -------------- | ----------------------------------------- | ------------------ |------------------------|---------------|------------------|--------------|--------------|------------|
 | *BC-0345797632* | 2020-04-27 | Puente Alto    | PF176-Parada 3 / (M) Plaza De Puente Alto | Horizontal pole    | Metal   | 40,458x	| 39.229x | Completo alta covertura | B.1 | GH
 | *BC-0345797645* | 2020-04-18 | *Home* (Ñuñoa) | *Home* (Control)                          | Control            | Desconocido | 2'832,4x |	2'656.5x | Completo alta covertura |  B.1 | GH
 | *BC-0345797802* | 2020-04-20 | Ñuñoa          | Santander Bank                            | ATM                | Metal |  725,07x |	703.12x | Completo alta covertura | B.1 | GH
 | *BC-0345797815* | 2020-04-27 | La Florida     | Metro Bellavista de la Florida            | ATM                | Metal |  51,855x | 50.284x | Completo alta covertura | B.1 | GH
 | *BC-0345797817* | 2020-04-13 | La Florida     | Metro Bellavista de la Florida            | ATM                | Metal |  92,894x |	90.078x | Completo alta covertura | B.1 | GH
 | *BC-0345798943* | 2020-04-20 | La Florida     | PE1262-Parada 5 / (M)                     | Information board  | Metal |  19,969x |	16.452x  | Completo covertura normal | B.1 | GH
 | *BC-0345799013* | 2020-04-27 | Puenta Alto    | PF512-Parada 2 / (M)                      | Horizontal pole    | Metal |  55,063x |	53.398x | Completo alta covertura | B.1 | GH
 | *BC-0361053718* | 2020-04-27 | Macul          | PD64-Parada 1 / Colegio San Marcos        | Pole               | Metal |  50,981x |	49.434x  | Completo alta covertura | B.1 | GH
 | *BC-0361053744* | 2020-04-20 | Ñuñoa          | Medical Center                            | Door handle        | Metal |  189,78x |	181.11x  | Completo alta covertura | B.1 | GH
 | *BC-0361057091* | 2020-04-29 | Ñuñoa          | Medical Center                            | Door handle        | Metal |  184.48x |	178.90x | Completo alta covertura | B.1 | GH

</center>

En Santiago el primer caso reportado por el Ministerio de Salud [Reporte](https://www.minsal.cl/ministerio-de-salud-confirma-tercer-caso-de-coronavirus-en-chile/) fue el tercer a nivel nacional el día 4 de marzo del 2020, que correspondería a una persona que precisamente había viajado a Europa e Italia, considerando días de incubación del virus, para esa fecha Italia se encontraría en plena curva exponencial del brote asociado a la variante B.1 de CoV-2, lo mismo pasara para los siguientes confirmados para Santiago (muchos parientes de los primeros casos), la mayoría con antecedentes de haber viajado a Italia y Europa, ingresando a finales de febrero e inicio de marzo y que estuvieron en contacto directo con familiares o conocidos y fueron propagando el virus. Teniendo su inicio en las comunas del sector Oriente de Santiago (Las Condes y Vitacura). A partir del 25 de marzo se anunciaron por parte del Gobierno de Chile las cuarentenas, 20 días después del primer caso, para las comunas del sector oriente y centro de Santiago, afectando a Lo Barnechea, Vitacura, Las Condes, Providencia, Santiago, Ñuñoa e Independencia. Para finales de mes, según el informe epidemiológico de Covid-19 de marzo [Informe](https://www.minsal.cl/wp-content/uploads/2020/03/INFORME_EPI_COVID19_20200330.pdf), las comunas que fueron muestreadas presentaban los siguientes casos: La Florida: 43, Macul: 10, Ñunoa: 67, Puente Alto: 45. El 7 de abril, se decreta Puente Alto (La mitad poniente, donde se encuentra la muestra *BC-0345797632*) con 119 casos confirmados, La Florida y Macul entrarían el 7 de mayo a cuarentena con 578 y 181, en esa misma fecha Ñuñoa sale de cuarentena con 365 casos, para volver una semana después a cuarentena junto a toda la provincia de Santiago. 
Con esta pequeña cronología de como el virus llego a la ciudad, es expando y las estrategias reportadas, anunciadas y publicadas por el Gobierno a través del Ministerio de Salud, posicionar las muestras en el mapa de Santiago, se puede observar que Ñuñoa que fue una de las primeras comunas en entrar a cuarentena fue siempre en las muestras seleccionadas, la que poseyó la mayor profundidad de secuenciación en comparación al resto, principalmente en la muestra asociada al cajero automático (*BC-0345797802*) utilizado frecuentemente por las personas y en un recinto que cumpliría con las condiciones para que el virus se pueda mantener por mas tiempo latente. Las muestras de Puente Alto, dos paraderos separados por la avenida Concha y Toro, utilizada para demarcar la cuarentena dinámica, una en el lado poniente con en cuarentena y el otro en el lado oriente en Jose Luis Coo, da a entender que el virus no respeta dicha delimitación, ni menos geográfica, el Virus esta presente en una profundidad similar a 20 días de decretada la cuarentena segmentada para Puente Alto. Para el caso de Macul (*BC-0361053718*)  que entro casi al final para la cuarentena para la provincia de Santiago, la muestra es de un paradero de transporte publico cercana a un colegio, San Marcos, la suspensión de actividades de jardines infantiles y colegios, públicos, subvencionados y privados se inicio el 15 de marzo. Por lo que a la toma de muestra el paradero no estaba a su máximo uso por los escolares en horario punta, aun así es considerablemente similar a las tomas de muestra de los paraderos de Puente Alto, consideran el espécimen que fue poste posa manos donde existe mayor probabilidad de contacto directo al virus con las manos, **estableciendo una correlación entre posición de la ciudad con respecto al virus**, siendo Puente Alto, La Florida y Macul comunas de preferencia residencial para el trabajo en comunas mas céntricas y del oriente de Santiago. La prohibición de trabajo en comunas de cuarentena se implemento posterior a la cuarentena total de la provincia de Santiago, por lo que el virus tuvo en total, mas de dos meses para circular por la ciudad antes del inicio del brote o primera ola.

</div>

## REFERENCIAS ##
[Volver a Tabla de Contenidos](#tabla-de-contenidos)

- **Chin, A., Chu, J., Perera, M., Hui, K., Yen, H. L., Chan, M., Peiris, M. & Poon, L. (2020)**. Stability of SARS-CoV-2 in different environmental conditions. *medRxiv*.
- **Santarpia, J. L., Rivera, D. N., Herrera, V. L., Morwitzer, M. J., Creager, H. M., Santarpia, G. W., Crown, K. K., Brett-Major, D. M., Schnaubelt, E. R., Boradhurst, M. J., Lawler, J. V., Reid, P. & Lawler, J. V. (2020)**. Aerosol and surface contamination of SARS-CoV-2 observed in quarantine and isolation care. *Scientific reports*, 10(1), 1-8.
- **Xue, X., Ball, J. K., Alexander, C., & Alexander, M. R. (2020)**. All surfaces are not equal in contact transmission of SARS-CoV-2. *Matter*.

## ANEXOS ##
#### [METADATAS COMPILADAS]()
#### [CODIGOS BASH](./anexos/codigos.html)
#### [RESUMENES ESTADISTICOS DE MAPEO](./anexos/stats.html)
#### [MAPAS DE COBERTURAS](./anexos/Mapa.html)
#### [ESTADISTICOS TRACER](./anexos/tracer.html)
#### [ARBOLES FILOGENETICOS]()