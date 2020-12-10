# Desafio_GK_GENCOMP

Desafío de Genomica Computacional
G. Krüger
Doctorado en Bioinformática y Biología de Sistemas

Este repositorio cuenta con un directorio main donde estará el archivo DESAFIO_GENOMICA_COMPUTACIONAL.html, que guiará por todo los directorios asociados a responder con el desafio.

Se respondieron a las 5 preguntas asociadas:

- ¿Podemos detectar CoV-2 en las muestras?
- ¿Podemos reconstruir los genomas?
- ¿Podemos detectar a que linaje pertenecen?
- ¿Dónde abundan, que variantes de CoV-2? 
- ¿Hay alguna correlación geográfica con respecto al CoV-2 detectado?

Se utilizaron los siguientes programas para responder al desafio ejecutados en subsistema ubuntu 20.04 LTS instalado en windows 10 x64

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
 
 Para el manejo de datos se utilizó python en interfaz de jupyter-lab v2.2.6
 Las especificaciones del computador con el que se trabajo:
 Procesador Intel i5-8400 2.8GHz
 Ram 32RAM (4X8Gb)
 GPU: NVIDIA 1660 Ti
 2 SSD 500GB
 1 HDD 1TB
 1 SSHD 1TB
 
 
 
