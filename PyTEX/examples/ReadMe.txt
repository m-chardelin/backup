

# Fonctionnement : 

	- deux temps de fonctionnement
	- treatment : traitement et nettoyage des fichiers de sortie de l'EBSD
	- extraction : traitement des ctf nettoyés, sortie des données dans un format exploitable dans un tableur ou python, des cartes, IPF et des CPO
	- les noms des fichiers crc ou cpr ne doivent pas contenir le caractère '_'
	- si tout marche bien, le script 'run' lance tout d'un coup 


#######################################################################################################
# Mise en place 

	- ajouter le dossier 'PyTEX' avec les sous dossiers dans le path Matlab 
	- taper 'install_mtex' dans la console Matlab
	- renseigner le chemin absolu du dossier des données dans la ligne MAIN_FOLDER 
	- configurer le dossier input : mettre les noms des lames dans les fichiers inputThinSections, configurer les paramètres de détection des grains dans le script analysisParameters, renseigner les noms des minéraux et les couleurs d'affichage dans les fichiers mineralColors, et mineralColorScale du sous dossier colors (mineralColors affecte la bonne couleur d'affichage et un standard aux autres fichiers de sortie de la macro)


#######################################################################################################
# Treatment 

	- entrée : le dossier data
	- sortie : le dossier dataClean (les fichiers dont les noms se terminent par r sont les données brutes non nettoyées converties en ctf, les fichiers terminant par c sont les données nettoyées converties en ctf)
	- les paramètres pour le nettoyage sont configurables, mais il faudrait tout tester à nouveau 

	- phasesEBSD : un fichier supplémentaire qui permet de vérifier que les noms affectés dans mineralColors correspondent bien aux noms des phases déclarées à l'EBSD
	- filesError : au cas où la conversion se passe mal, ce fichier contient les noms des fichiers crc ou cpr qui n'ont pas marché


#######################################################################################################
# Extraction 

	- entrée : le dossier dataClean
	- sortie : output/total
	
	- LAME_MINERAL_Grains = les données pour chaque grains, dans le minéral et la lame donnée
	- LAME_MINERAL_EBSD = les données pour chaque pixel, dans le minéral et la lame donnée
	- LAME_MINERAL_Boundaries = les coordonnées des limites de grains (pour l'affichage en python)
	- LAME_MINERAL_InnerBoundaries = les coordonnées des limites de sous grains (pour l'affichage en python)
	- LAME_Neighbors = les paires de grains en contact sur la lame donnée (pour les statistiques en python)
	- param = les paramètres utilisés pour la reconstruction des grains
	- egdsf = les paramètres géométriques moyens pour chaque minéral de chaque lame (EGD, SF)
	- index = les index AC, BA, BC pour les minéraux données dans le script principal, pour chaque lame (possibilité de trier des sous ensemble de grains et de calculer les indices aussi) : à voir si les indices données sont pertinents pour les minéraux données
	- area = fait des rapports de surface pour chaque minéral par rapport à la totalité de la surface de l'échantillon, ou seulement aux pixels indexés, calcule le nombre de grains total, et le nombre de grains gardés si la variable smallGrainsOption est supérieure à 0

	- cartes : affichables avec la fonction 'createMap', mapGROD et mapKAM 
	- les CPO sont crées à partir de la fonction CPO, qui affiche le CPO avec l'échelle de couleur définie pour chaque minéral. Si le nombre de grains est inférieur à 150, la fonction n'affiche plus la densité mais un point par grain sur chaque stéréogramme afin de ne pas fausser la lecture