library(TPD)
caete_50pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out50_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_50pls)
dim(caete_50pls)
caete_50pls_traits_column<-caete_50pls[,21:26] #select the traits columns
pca_50pls <- prcomp(caete_50pls_traits_column, scale=TRUE) #performs a PCA for
pca_50pls_axes<-pca_50pls$x
pca_50pls_df<-as.data.frame(pca_50pls_axes)
npls<-rep('50PLS',dim(pca_50pls_df)[1])
pca_50pls_df<-cbind(pca_50pls_df[,1:3],npls)
names(pca_50pls_df)

caete_100pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out100_mean_runs_temperate.csv", header = TRUE) #calls the file
names(caete_100pls)
dim(caete_100pls)
caete_100pls$region<-NULL
names(caete_100pls)
caete_100pls_traits_column<-caete_100pls[,21:26] #select the traits columns
pca_100pls <- prcomp(caete_100pls_traits_column, scale=TRUE) #performs a PCA for
pca_100pls_axes<-pca_100pls$x
pca_100pls_df<-as.data.frame(pca_100pls_axes)
npls<-rep('100PLS',dim(pca_100pls_df)[1])
pca_100pls_df<-cbind(pca_100pls_df[,1:3],npls)
names(pca_100pls_df)

caete_diss<-rbind(pca_50pls_df,pca_100pls_df)
traits<-caete_diss[,1:3]
pls_number<-caete_diss$npls
TPDs_dis<-TPDs(species=pls_number,traits)
dissimilarity<-dissim(TPDs_dis)
dissimilarity

