---
title: Installer une VM Ubuntu sur VirtualBox
author: Mickael A.
date: 2020-10-06 21:05:00 +0100
categories: [Tutorial, Débutant, French]
tags: [linux, vm]
---

Niveau: Débutant  
Ce tutoriel est destiné à des utilisateurs débutants qui souhaitent installer une machine virtuelle Ubuntu sur leur ordinateur. Les méthodes présentées ici ne sont pas forcément les plus optimisées ou les plus efficaces, mais elles sont simples et devraient convenir à tous les utilisateurs ciblés.

# Prérequis

## Télécharger Ubuntu
Avant de commencer, il va falloir télécharger une image ISO de Ubuntu. Une image ISO c'est comme un disque qu'on met dans un lecteur de disque, mais virtuel. Et votre ordinateur sait la lire comme si c'était un vrai disque.  
Pour télécharger une image disque de Ubuntu, rendez-vous sur [le site de Ubuntu](https://ubuntu.com/download/desktop). Vous aurez le choix entre deux versions principalement. La première version proposée est la version LTS (Long-Time Support), c'est une version dont le support durera 5 ans. C'est ce que je vous conseille de choisir. Sinon, nous avons juste en dessous la version la plus récente. Rassurez-vous, la nouveauté ne veut pas dire qu’elle contient des failles ou qu’elle n’est pas
corrigée.  
Pour les plus avancés qui souhaiteraient installer un autre système (Debian, Fedora ...), vous
pourrez trouver tous les liens sur [le site Linux](https://linux.org/pages/download/).  
Les images ISO de Ubuntu pèsent environ 2 Go, c'est pourquoi cette étape est à prévoir à l'avance.  
Une fois que cette image ISO est téléchargée, vous allez la placer dans un dossier où elle ne bougera pas, par exemple dans un dossier dans vos Documents.

## Activer la virtualisation
La virtualisation est une technologie permettant à votre ordinateur de simuler un autre ordinateur virtuel. Ce n’est pas une option activée par défaut sur toutes les cartes mères, donc il va falloir entrer dans le BIOS pour l’activer.  
**Attention, cette étape devra sûrement être répétée plusieurs fois jusqu’à ce que vous trouviez la bonne méthode.**  
On va donc éteindre le pc et le rallumer. Au moment où il s’allume, au moment où vous
appuyez sur le bouton, il va falloir appuyer très rapidement et répétitivement sur la touche vous permettant d'entrer dans le bios. La solution la plus simple pour connaitre cette touche est de chercher sur internet "xxxx bios key", où xxxx est la marque de votre ordinateur portable, ou de votre carte mère si c'est un ordinateur fixe. Avec certains ordinateurs, un message peut s’afficher disant « Press XXX key to enter setup » , il s’agit de la touche que nous cherchons). Je possède un ordinateur portable HP, il s’agissait donc de la touche F10 pour moi.  
Une fois dans le BIOS, nous allons arriver sur un écran semblable à celui-ci (encore une fois, il sera différent selon l'ordinateur).  
![bios](/vmubuntu/1.png)  
Maintenant, il va falloir chercher. Pour moi, dans « Sécurité » je peux activer la virtualisation, mais l’option peut être cachée dans d’autres onglets. Pour chercher ça, gardez à l’esprit que vous cherchez une option de **sécurité** concernant le **CPU**.  
Une fois la virtualisation activée, quittez en sauvegardant les paramètres et retournez sur votre système d'exploitation.

# Installer VirtualBox
Rendez-vous sur [le site de VirtualBox](https://www.virtualbox.org/wiki/downloads) et téléchargez l'application en cliquant sur le système correspondant au vôtre.  
![virtualboxsite](/vmubuntu/2.png)  
Une fois téléchargé, exécutez le fichier d'installation. L’installateur n’ajoute pas de programmes indésirables, donc vous pouvez accepter tout sans prêter attention. Vous pouvez changer le chemin d’installation pour les plus avancés. L’installateur vous demandera d’installer des pilotes supplémentaires, cochez « Toujours faire confiance » et acceptez.  
Pour ceux qui possèdent des prises USB 3 sur leur PC, il va falloir installer une extension pour pouvoir les supporter. Si vous ne savez pas si vous en avez, je vous conseille de l’installer quand même. Retournez donc sur [la section téléchargements](https://www.virtualbox.org/wiki/Downloads). L’extension se trouve ici :  
![vbextension](/vmubuntu/3.png)  
Une fois téléchargée, elle apparaîtra comme ceci:  
![vbextension1](/vmubuntu/4.png)  
Double-cliquez, elle s’ouvrira dans VirtualBox en vous demandant de confirmer l’installation, acceptez.

# Créer la machine virtuelle
Ouvrez VirtualBox.  
![virtualbox](/vmubuntu/5.png)  
1. La liste de vos machines virtuelles (VM)
2. Résumé des paramètres de la VM sélectionnée
3. Outils de contrôle

Cliquez sur "Nouvelle". En tapant "ubuntu" comme nom de VM, VirtualBox reconnaîtra automatiquement que vous voulez installer un système Linux de type Ubuntu. Sinon mettez votre nom personnalisé et Sélectionnez-le manuellement. Vous remarquerez que le système sélectionné est 64-bits. Si ce n'est pas le cas, il faudra réessayer d'activer la virtualisation.  
![vb1](/vmubuntu/6.png)  
On vous demandera ensuite d'allouer de la mémoire vive à la VM. Selon la quantité que vous avez (écrit en-dessous à droite de la barre), je vous conseille d'allouer 4096Mio de RAM, sinon 2048.  
![vb2](/vmubuntu/7.png)  
Acceptez de créer un disque dur virtuel maintenant, type VDI, dynamiquement alloué (laissez tout coché par défaut).  
Vous pouvez attribuer l’espace de stockage initial (par défaut il réclame 10Go mais vous pouvez mettre moins, un minimum de 8Go est cependant nécessaire). On voit le chemin du dossier de stockage de la VM (pour moi F:\ubuntu), il peut être changé pour cette VM, sinon pour changer le chemin par défaut retournez au menu principal de VirtualBox, Fichier, Paramètres et changez le chemin par défaut.  
![vb3](/vmubuntu/8.png)  
Une fois votre VM créée, sélectionnez-la et cliquez sur "Configuration".  
Dans "Système", "Processeur", je conseille d'allouer au moins 2 coeurs de votre Processeur à la VM.  
Dans "Affichage", mettez la mémoire vidéo au maximum (128Mo).  
Dans "USB", cochez "contrôleur 3.0".  
Cliquez sur "OK" et lancez votre VM en double-cliquant sur son nom ou sur le bouton "Démarrer".

# Installation d'Ubuntu
VirtualBox vous demandera le disque de démarrage, c'est l'image disque que nous avons téléchargé précédemment.  
Sélectionnez la langue de votre choix et cliquez sur "Installer Ubuntu".  
![ubu1](/vmubuntu/9.png)  
Sélectionnez la disposition du clavier ( Français azerty) et cliquez sur « Suivant » si vous le voyez, sinon vous pouvez déplacer la fenêtre pour le voir.  
![ubu2](/vmubuntu/10.png)  
Cochez "Télécharger les mises à jour" pour gagner du temps par la suite.  
![ubu3](/vmubuntu/11.png)  
Laissez "Effacer le disque" coché. Actuellement, vous êtes sur un disque dur virtuel vide, vous ne perdrez donc pas de données de votre vrai disque dur.  
![ubu4](/vmubuntu/12.png)  
Sélectionnez le fuseau horaire, puis entrez un nom, un nom pour la machine, un nom d'utilisateur et un mot de passe. Attention, vous devrez rentrer ce mot de passe pour chaque commande administrateur sur la VM, je vous conseille donc un mot de passe court, même si le système précise que c'est trop court. Je vous recommande aussi de cocher "Ouvrir la session automatiquement".  
Laissez l'installation se faire, puis acceptez le redémarrage. Encore une fois, comme c'est une machine virtuelle, seule la machine virtuelle va se redémarrer.

# Compatibilité
Actuellement votre VM est totalement coupée du reste de votre ordinateur et n’est même pas capable de s’afficher dans une résolution décente. Ouvrez un terminal et tapez `sudo apt-get install dkms`.
* Pour certaines versions, dkms n’est pas disponible. Cliquez sur ce lien pour télécharger [l’archive deb de dkms](http://ftp.fr.debian.org/debian/pool/main/d/dkms/dkms_2.2.0.3-2_all.deb). Ouvrez un terminal et déplacez-vous dans le dossier ~/Downloads, puis tapez `sudo dpkg -i dkms_....` (vous pouvez taper "dkms" puis appuyer sur TAB pour que le terminal complète automatiquement le nom).

Une fois dkms installé, dans la barre au-dessus de la VM, dans l’onglet Périphériques, cliquez sur "Insérer l’image CD des additions invité". Cliquez sur "Run", laissez installer puis fermez la VM.  
Attention : Il faut impérativement installer dkms avant le CD sous peine de freezer la VM à l’infini !  
Si votre ordinateur possède la touche CONTROLE_DROITE, vous pouvez directement redémarrer la VM. Sinon, "Fichier", "Paramètres", "Entrée", "Machine virtuelle" et cliquez sur la première case "Combinaison de touche hôte" dans la colonne raccourcis. Ensuite attribuez une touche de contrôle (le plus simple étant d’utiliser SHIFT_DROIT). Cliquez OK et relancez votre VM.  
Les touches qui vous seront utiles sont les suivantes (en supposant que HOST est la touche que vous venez d’attribuer):  
* HOST+F : basculer la plein écran  
* HOST+R : redémarrer la VM  
* HOST+E : prendre une capture d’écran  

Lorsque vous êtes en plein écran, la barre de contrôle se situe sur la bordure basse de l’écran. Si vous cliquez sur périphériques, vous pourrez connecter les différents périphériques branchés sur votre ordinateur (principalement les clés USB).

# Lier les disques durs
**Je ne recommande pas de donner à une VM l'accès à vos disques durs. Cependant, dans certains cas c'est nécessaire. Cette partie décrira la méthode pour lier les disques durs entiers. Si vous souhaitez transférer des fichiers de votre ordinateur à votre VM, je vous conseille de faire la même chose mais avec un dossier en particulier plutôt que les disques durs entiers.**  
Avant de démarrer cette étape, je vous conseille d’activer le presse-papier bidirectionnel et le glisser-déposer bidirectionnel dans la barre de contrôle, "Périphériques".  
Dans la barre de contrôle, "Machine", "Configuration", "Dossiers partagés". Cliquez sur le dossier bleu avec un + vert à droite. Dans chemin du dossier, vous pouvez chercher un dossier en particulier ou bien partager directement votre (vos) disque(s) dur(s). Pour cela, Il suffit de taper le chemin du disque ou du dossier puis cocher "configuration permanente" et "Montage automatique".  
![vb4](/vmubuntu/13.1.png)  
![vb5](/vmubuntu/13.2.png)  
Comme vous pouvez le voir ici, je possède deux disques durs que je veux partager à ma VM: C: et D:.  
Normalement, les dossiers partagés sont automatiquement gérés par VirtualBox et sont automatiquement disponible dans la VM au démarrage. Cependant, sur des VM Linux on peut observer quelques problèmes, comme l'interdiction en écriture sur les dossiers partagés. C'est pourquoi j'utilise la méthode alternative suivante.  
Créez un dossier pour chaque dossier partagé (pour moi ils s'appelleront "SSD" et "DATA").  
![ubu5](/vmubuntu/14.png)  
Editez un fichier ".sh" avec un nom facile à taper (pour moi ça sera "dd.sh"). Tapez le code suivant:  
```bash
mount -t vboxsf NAME CHEMIN/DU/DOSSIER
```
Recopiez cette ligne pour chaque dossier partagé, où "NAME" est le nom du dossier partagé qu'on a vu dans les paramètres des dossiers partagés, et "CHEMIN/DU/DOSSIER" est le chemin du dossier que vous venez de créer.  
Pour moi ça donne donc:  
![ubu6](/vmubuntu/15.png)  
Vous devrez exécuter ce script en superutilisateur à chaque fois que vous voudrez accéder à(aux) dossier(s) partagé(s). Le partage sera actif jusqu'à ce que vous éteignez la VM ou que vous les détachiez manuellement (pour les utilisateurs très avancés).  
![ubu7](/vmubuntu/16.png)  
