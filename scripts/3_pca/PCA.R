###Script written by Peter Scott UCLA and modified by C. Kazilas

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager:::install("gdsfmt")
BiocManager:::install("SNPRelate")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("rlang")
install.packages("ggrepel")

library(gdsfmt)
library(SNPRelate)
library(ggplot2)
library(RColorBrewer)
library(cowplot)
library(ggrepel)

VCF <- "<path_to_file>/<VCF_filtered>.recode.vcf"

snpgdsVCF2GDS(VCF, "<path_to_R_file>/PCA.gds", method="biallelic.only")

snpgdsSummary("<path_to_R_file>/PCA.gds")

PCAgds<- snpgdsOpen("<path_to_R_file>/PCA.gds")
#lycia99gds<- snpgdsClose(gds)
#lycia99gds2<- openfn.gds("lycia99vcf.gds")
#lycia99gds3<- openfn.gds("lycia99vcf.gds",readonly = FALSE)
#closefn.gds(lycia99gds3)
###PCA
PCA <- snpgdsPCA(PCAgds, autosome.only = FALSE)
PCA
pc.percent <- MPEPCA$varprop*100
(round(pc.percent, 2))

tab <- data.frame(sample.id = PCA$sample.id,
                  EV1 = PCA$eigenvect[,1], # the first eigenvector
                  EV2 = PCA$eigenvect[,2], # the second eigenvector
                  stringsAsFactors = FALSE)
head(tab)

file.names<-read.csv("<path_to_txt_file>/filenames_PCA.txt",sep="\t")
head(file.names)

##plot PCA with no colors
plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")



####This is for PCA with 4 or 8 colors

pop=file.names$pop.code

tab12 <- data.frame(sample.id = file.names$sample.id,
                    Species = file.names$pop.code,
                    #shape = lycia99names$shape.code,
                    EV1 = PCA$eigenvect[,1], # the first eigenvector
                    EV2 = PCA$eigenvect[,2], # the second eigenvector
                    key = pop)

tab13 <- data.frame(sample.id = file.names$sample.id,
                    Species = file.names$pop.code,
                    #shape = lycia99names$shape.code,
                    EV1 = PCA$eigenvect[,1], # the first eigenvector
                    EV3 = PCA$eigenvect[,3], # the second eigenvector
                    stringsAsFactors = FALSE)

tab23 <- data.frame(sample.id = file.names$sample.id,
                    Species = file.names$pop.code,
                    #shape = lycia99names$shape.code,
                    EV2 = PCA$eigenvect[,2], # the first eigenvector
                    EV3 = PCA$eigenvect[,3], # the second eigenvector
                    stringsAsFactors = FALSE)

tab24 <- data.frame(sample.id = file.names$sample.id,
                    Species = file.names$pop.code,
                    #shape = lycia99names$shape.code,
                    EV2 = PCA$eigenvect[,2], # the first eigenvector
                    EV4 = PCA$eigenvect[,4], # the second eigenvector
                    stringsAsFactors = FALSE)

tab14 <- data.frame(sample.id = file.names$sample.id,
                    Species = file.names$pop.code,
                    #shape = lycia99names$shape.code,
                    EV1 = PCA$eigenvect[,1], # the first eigenvector
                    EV4 = PCA$eigenvect[,4], # the second eigenvector
                    stringsAsFactors = FALSE)

pop.colors2<-c("forestgreen", "burlywood4")

### Change the percentages accordingly

gplot12 <- ggplot(tab12, aes(EV1,EV2,color=Species)) + geom_point(size=3) +
  scale_color_manual(values=pop.colors2) +
  xlab("PC1 (18.84%)") +
  ylab("PC2 (3.27%)") +
  theme_bw() 

gplot13 <- ggplot(tab13, aes(EV1,EV3,color=Species)) + geom_point(size=3) +
  scale_color_manual(values=pop.colors2) +
  xlab("PC1 (18.84%)") +
  ylab("PC3 (3.20%)") +
  theme_bw() 

gplot23 <- ggplot(tab23, aes(EV2,EV3,color=Species)) + geom_point(size=3) +
  scale_color_manual(values=pop.colors2) +
  xlab("PC2 (3.27%)") +
  ylab("PC3 (3.20%)") +
  theme_bw() 

gplot24 <- ggplot(tab24, aes(EV2,EV4,color=Species)) + geom_point(size=3) +
  scale_color_manual(values=pop.colors2) +
  xlab("PC2 (3.27%)") +
  ylab("PC4 (2.48%)") +
  theme_bw() 

gplot14 <- ggplot(tab14, aes(EV1,EV4,color=Species)) + geom_point(size=3) +
  scale_color_manual(values=pop.colors2) +
  xlab("PC1 (18.84%)") +
  ylab("PC4 (2.48%)") +
  theme_bw() 

gplot12 + geom_text_repel(aes(label = sample.id))
gplot13 + geom_text_repel(aes(label = sample.id))
gplot23 + geom_text_repel(aes(label = sample.id))