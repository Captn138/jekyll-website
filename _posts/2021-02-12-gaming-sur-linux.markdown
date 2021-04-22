---
title: Gaming sur Linux
author: Mickael A.
date: 2021-02-12 12:00:00 +0100
categories: [Tutorial, Avancé, French]
tags: [linux, gaming]
---


Niveau: Avancé  
Comment optimiser son système Linux pour maximiser les performances en jeu et la compatibilité.  
![BTF Tux](/gamingonlinux/borntofrag.jpg)

# Introduction
Durant l’intégralité de ce guide, j’utiliserai mon propre ordinateur portable. Ce dernier est équipé d’un processeur (Computing Processing Unit = CPU) Intel Core-i7 7500U et d’une carte graphique (Graphics Processing Unit = GPU) Nvidia GeForce 940MX, et mon Système d’Expoiltation (Operating System = OS) installé est Pop!_OS 20.10. Je partirai donc du principe que vous savez faire une clé USB bootable, que vous savez booter et installer un OS depuis une clé USB et que vous savez vous servir de Linux et de son terminal.

# Le cas Intel-Nvidia
<img src="/const/intel.png" height="100">  
<img src="/const/nvidia.png" height="100">
## GPU Hybrides
Lorsqu’on cherche à jouer à quelques jeux sur son PC Linux, le premier problème auquel on doit s’atteler est celui du CPU. En effet, les processeurs de la marque Intel viennent quasiment toujours avec un Processeur Graphique Intégré (Integrated Graphics Processor = IGP). Sur un ordinateur portable, cet IGP va s’occuper (sur Windows) de gérer l’affichage le plus basique et lorsque l’on a besoin d’affichages plus complèxes, le GPU prend le relai. Pour les processeurs de la marque AMD, ce n’est pas le cas car les seuls CPU équipés d’IGP sont ceux dont la référence finit par “G”, or nous n’en trouvons pas sur les ordinateurs portables. Sur les PC fixes, nous n’aurons pas ce problème car l’affichage n’est géré que par le CPU ou le GPU dans le cas où nous en avons un. Sur les ordinateurs portables qui n’ont pas de GPU, nous n’auront pas ce problème non plus. Comme vous pouvez donc le comprendre, cette première partie du guide est dédiée aux utilisateurs d’un ordinateur portable, possédant un CPU Intel et un GPU Nvidia.  
![gpu hybride](/gamingonlinux/hybridgpu.jpg)  
Cette association d’un IGP et d’un GPU est appelé GPU Hybride. Le problème principal des GPU Hybrides est qu’ils ne sont pas supportés par défaut sur Linux. Il se peut cependant que certaines distributions viennent avec ce support intégré par défaut. La première manifestation de ce problème, et celle qui décourage bon nombre de débutants dans le domaine de Linux (dont moi aussi à une époque) est l’installation d’une distribution Linux. En effet, à cause de ce GPU Hybride, on peut faire face à un freeze de l’installation qui survient généralement toujours au même moment sans généralement de cause visible (notamment lors de la détection des disques).  

## Amorçage safe
Lors de l’amorçage sur votre clé USB contenant l’image Linux de sa distribution, on va commencer par appuyer sur une touche directionnnelle de notre clavier afin d’interrompre la séquence d’amorçage. On devrait pouvoir observer un menu avec des modes de démarrage. Sur la plupart des OS Linux, il suffira d’appuyer sur E après avoir déplacé la sélection sur le choix principal pour éditer les options. Nous allons ensuite éditer les options de démarrage afin d’inclure une option qui va nous permettre de forcer l’utilisation d’un seul processeur graphique à la fois. On va se déplacer à la ligne qui commence par « linux », on va se déplacer tout à la fin de cette ligne et ajouter les options suivantes après le « quiet splash » ou « quiet » selon la distribution.  
`... quiet splash pci=nomsi acpi=force`  
![grub edit](/gamingonlinux/1.png)  
Attention, généralement le clavier est en QWERTY, pensez donc que le A est sur le Q et le M est sur la virgule. Ensuite, nous appuierons sur CTRL+X pour exécuter avec les options éditées manuellement. Nous pourrons ensuite procéder à l’installation normale.  
Dans le cas où vous avez déjà installé Linux et que vous n’avez jamais eu besoin d’ajouter ces options, pas de panique, lisons la suite de ce guide.

## Démarrage safe pour toujours
Pour fixer les options de démarrage qu’on vient de taper, on va éditer le fichier suivant en root:  
`/etc/default/grub`  
et on va ajouter les mêmes options que précédemment à la ligne:  
`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=nomsi acpi=force"`  
Ensuite dans un terminal et toujours en root:  
`update-grub`  
Je conseille un premier reboot pour confirmer les changements. On pourra éditer les options de démarrage dans Grub avec E pour vérifier que nos options sont bien là par défaut.


# Drivers Graphiques

## Installation automatique
La plupart des distributions Linux peuvent détecter et installer automatiquement les drivers appropriés. C’est pourquoi je conseille d’utiliser une distribution avec un large support comme les Debian, Ubuntu et dérivés ou les Arch, Manjaro et dérivés.  
Selon la distribution, un logiciel peut être déjà préinstallé vous permettant de gérer et mettre à jour vos drivers graphiques (software-properties, kcmshell5 devinfo etc). Bien sélectionner le dernier driver propriétaire du fabriquant de votre GPU.  
![software-properties-gtk on pop!_os](/gamingonlinux/2.png)  
Sous Manjaro, il extist le très célèbre `mhwd`.

## Activer l'architecture 32 bits
Activer l'architecture 32 bits avant d'installer ses drivers vidéo permettra un bon support dans les applications en 32 bits et notamment plus tard avec Wine.  
![debian](/const/debian.png)  
Pour Debian, Ubuntu et dérivés:
```bash
sudo dpkg --add-architecture i386 
```
![arch](/const/arch.png)  
Pour Arch et dérivés:  
Editer le fichier `/etc/pacman.conf` et décommenter les lignes suivantes (les rajouter si elles ne sont pas présentes):
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

## Nvidia
![nvidia](/const/nvidia.png)  
L'installation des drivers GPU propriétaires Nvidia se fait via les commandes suivantes:  
![debian](/const/debian.png)
```bash
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install nvidia-driver-450 libnvidia-gl-450 libnvidia-gl-450:i386 libvulkan1 libvulkan1:i386 -y
```
![arch](/const/arch.png)  
Alternativement, voir [le site Nvidia](https://www.nvidia.com/en-us/drivers/unix/) (surtout pour les OS autres que basés sur Debian).  

## AMD
![amd](/const/amd.png)  
L'installation de drivers Mesa pour GPU AMD se fait via les commandes suivantes:  
![debian](/const/debian.png)  
Pour Debian, Ubuntu et dérivés:
```bash
sudo add-apt-repository ppa:kisak/kisak-mesa -y
sudo apt update
sudo apt install libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y
```
![arch](/const/arch.png)  
Pour Arch et dérivés:
```bash
sudo pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader -y
```
Alternativement, voir [la documentation officielle](https://www.amd.com/en/support/kb/faq/amdgpu-installation).

### AMD ACO
![amd](/const/amd.png)  
L'activation de cette option permet une compilation plus rapide **uniquement** avec les GPU AMD.  
Il suffit d'ajouter la ligne suivante à `/etc/environment`.
```
RADV_PERFTEST=aco
```

# Kernel custom
Un kernel custom permet d'avoir des paramètres système très optimisés. On peut grâce à ce dernier gagner des performances dans les jeux. En théorie, Xanmod est le plus performant, suivi de près par Liquorix. Une alternative existe pour les utilisateurs de Arch: Zen. Après l'installation de votre kernel custom, je vous invite à lancer grub-customizer pour définir l'option de démarrage avec le kernel custom comme votre option par défaut (documentation sur grub-customizer [ici](https://doc.ubuntu-fr.org/grub-customizer)).  
**Attention, je ne recommande pas forcément l'utilisation d'un kernel custom, car il peut casser un certain nombre de paquets et de modules qu'il faudra réinstaller. Le kernel par défaut de votre distribution devrait pouvoir totalement faire l'affaire.**
## Xanmod
![debian](/const/debian.png)  
Pour l'installation sur Debian, Ubuntu et dérivés:
```bash
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
sudo apt update && sudo apt install linux-xanmod -y
```
![arch](/const/arch.png)  
Pour Arch et dérivés, on peut installer ce kernel, mais il faudra alors le build, et ce processus peut prendre jusqu'à plusieurs heures:
```bash
yay -S linux-xanmod
```
Plus d'infos sur [le site](https://xanmod.org/)

## Liquorix
![debian](/const/debian.png)  
Pour l'installation sur Debian, Ubuntu et dérivés:
```bash
sudo add-apt-repository ppa:damentz/liquorix && sudo apt-get update -y
sudo apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64 -y
```
![arch](/const/arch.png)  
Pour Arch et dérivés, on peut installer ce kernel, mais il faudra alors le build, et ce processus peut prendre jusqu'à plusieurs heures:
```bash
yay -S linux-lqx
```
Plus d'infos sur [le site](https://liquorix.net/)

## Zen (Arch uniquement)
![arch](/const/arch.png)  
Zen est un kernel custom qui reprend la plupart des améliorations de Liquorix et a un package prêt à l'installation directement dans Arch. Son installation peut être une bonne alternative au build d'un kernel.
```bash
pacman -S linux-zen -y
```


# Optimisation CPU
[GameMode](https://github.com/FeralInteractive/gamemode) est un programme qui permet d’optimiser le profil de votre CPU lorsque vous lancez un jeu. Pour installer, rendez-vous sur le GitHub, dans le README.md, vous trouverez une section « Development/Install dependencies » avec les dépendances à installer. Ensuite, la section « Development/Build and install GameMode » explique comment installer.  
```bash
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.6
# 1.6 est la dernière version au moment où je fais ce guide. Se référer à https://github.com/FeralInteractive/gamemode#build-and-install-gamemode
./bootstrap.sh
```  
Pour lancer un jeu avec GameMode:  
`gamemoderun /path/to/game/executable`  
ou en argument Steam:  
`gamemoderun %command%`


# Mes FPS: MangoHud
MangoHud est une application qui s’affiche par-dessus un jeu pour afficher différentes informations comme l’utilisation CPU/GPU/RAM, les températures, ainsi que le nombre d’Images Par Secondes (Frames Per Second = FPS). Pour l’installer, rendez-vous sur [la page GitHub](https://github.com/flightlessmango/MangoHud). Dans la section « Installation », vous pouvez « Build and Install » ou simplement télécharger une version pré-compilée et l’installer.  
Pour lancer un jeu avec MangoHud:  
`mangohud /path/to/game/executable`  
ou en argument Steam:  
`mangohud %command%`  
Certains jeux OpenGL auront des problèmes avec MangoHud, il faudra donc ajouter MANGOHUD_DLSYM=1 avant la commande:  
`MANGOHUD_DLSYM=1 mangohud /path/to/game/executable`  
mais nous pourrons gérer ça plus tard avec Lutris ou avec Steam.  
MangoHud est complètement configurable. Vous trouverez un fichier de config example à copier et à éditer afin de mettre en place votre propre configuration.  
`cp /usr/share/doc/mangohud/MangoHud.conf.example ~/.config/MangoHud/MangoHud.conf`  
![mangohud](/gamingonlinux/4.png)


# Wine
Wine est une couche de compatibilité permettant de transformer des appels au kernel Windows en appels au kernel Linux. Dans la pratique, Wine permet d’exécuter des applications Windows (.exe) sur Linux. Dans un terminal, tapez « wine » suivi de l’exécutable Windows et observez la magie. Sur le site de Wine, vous trouverez des instructions d’installation pour plusieurs distributions, mais n’hésitez pas à chercher sur internet comment installer si votre distribution n’est pas dans celles précisées sur [le site](https://wiki.winehq.org/Download).  
![wine](/gamingonlinux/5.png)  

![arch](/const/arch.png)  
Pour les distribustions basées sur Arch, Wine est disponible à l'installation directement via Pacman:
```bash
sudo pacman -S wine-staging
```

## Wine en profondeur
Je recommande l'installation des packages suivants: `wine-mono wine-gecko`.  
Ici le package `wine-gecko` permet le support des applications qui dépendent d'Internet Explorer (oui oui ce n'est pas une blague) et le package `wine-mono` permet le support des applications qui dépendent de .NET.
On peut aussi associer l'exécution de n'importe quel fichier .exe avec Wine en installant « wine-binfmt ». Dans votre explorateur de fichiers, associez ensuite le type d'application avec Wine. Pour Nautilus par exemple, il faut regarder les propriétés du fichier, section « Ouvrir avec ».

# Steam et Proton
Même si vous n’avez pas de compte ni de jeux Steam, je vous conseille de télécharger le client Steam pour Linux et de vous créer un compte, afin de pouvoir utiliser Proton.  
Ouvrez les paramètres dans Steam, Paramètres.  
![steam1](/gamingonlinux/6.png)  
Dans « Steam Play », cochez les deux cases et sélectionnez la dernière version de Proton.  
![steam2](/gamingonlinux/7.png)  
Ensuite, dans la liste des jeux, tapez « proton ». Vous aurez la liste de toutes les versions de Proton disponibles. Pour télécharger une version particulière, double-cliquez sur la version souhaitée et installez-là (ou clic droit, Installer).  
![steam3](/gamingonlinux/8.png)  
Ceci vous permettra d’exécuter vos jeux Steam qui ne sont pas nativement développés pour Linux à travers Proton, une évolution de Wine tournée vers le jeu vidéo.  
Pour ajouter des arguments Steam à un jeu (malheureusement il n’existe pas encore d’option pour configurer globalement), clic droit sur un jeu, « Propriétés ». Cliquez sur « Définir des options de lancement » et ajoutez vos arguments. %command% sert à indiquer où est la commande de lancement de jeu. Par exemple:  
`MANGOHUD_DLSYM=1 mangohud gamemoderun %command%`


# Lutris: un des meilleurs launchers
Lutris est, si ce n’est le meilleur, l’un des meilleurs launchers de jeux pour Linux. Pour l’installer, suivre les instructions correspondant à votre distribution sur [le site](https://lutris.net/downloads/). Une fois installé, Lutris ressemblera à ça:  
![lutris1](/gamingonlinux/9.png)

## Wine pour Lutris
A gauche, cliquez sur le rouage près de « Runners ». Nous allons installer Wine pour Lutris. Il s’agit de versions de Wine légèrement modifiées pour être plus optimisées pour le jeu vidéo. Descendez jusqu’à Wine et cliquez sur le bouton d’installation. Il vous faudra ensuite choisir quelles versions télécharger. Je vous conseille de télécharger la dernière version de Lutris ainsi que la dernière version de tkg-protonified.

## Paramètres de Lutris
Je pense qu’une bonne chose à faire avant d’ajouter des jeux à Lutris est de jeter un oeil dans les paramètres. On y accède en cliquant sur l’icône à trois barres horizontales en haut à droite, puis sur « Preferences ». Dans « System Options » nous trouverons ce qui est le plus intéressant, ce sont les options de lancement globales des jeux. La première chose qu’on peut voiloir activer est « Disable Desktop Effects » qui nous permettra d’économiser un peu de puissance graphique quand on joue. Pour les utilisateurs avancés qui utilisent le mode graphiques hybrides dont je n’expliquerai pas la configuration ici, il est judicieux d’activer « Enable NVIDIA Prime Renderer Offload ». On peut activer GameMode directement grâce à « Enable Feral Gamemode ». Enfin, si on utilise une application pour afficher nos FPS comme Mangohud, on peut ajouter une « Environment Variable »:  

| key | value |
|-------|--------|
| MANGOHUD_DLSYM | 1 |

Pour finir, nous pouvons ajouter « mangohud » en « Command Prefix ».  
Chacune de ces options peuvent être overridées dans la configuration particulière de chaque jeu.

## Importer des jeux
En cliquant sur le bouton « + » en haut à gauche, on va pouvoir importer les jeux de nos comptes GOG, Steam et HumbleBundle. Ils seront ensuite disponibles au téléchargement depuis Lutris via ces plateformes. On peut aussi détecter les jeux déjà installés sur notre PC.  
![lutris2](/gamingonlinux/10.png)

## Ajouter des jeux
Lorsque vous souhaitez ajouter un jeu à Lutris, vous pouvez faire apparaître la barre de recherche en appuyant sur CTRL+F puis en cliquant sur le bouton « Search Lutris ». Cherchez votre jeu et cliquez sur « Installer ». La plupart du temps, vous trouverez au moins une configuration pour votre jeu.  
![lutris3](/gamingonlinux/11.png)  
![lutris4](/gamingonlinux/12.png)  
Cliquez sur la configuration souhaitée et suivez les étapes. Un autre avantage de Lutris est qu’il permet aussi de centraliser certains émulateurs.  
![lutris5](/gamingonlinux/13.png)  
Evidemment, on peut ajouter des jeux manuellement, dans le cas où on se retrouve pour des raisons diverses et variées avec une copie d’un jeu Windows par exemple (lepiratagedejeuxnestpascautionnéparceguidepourvotresantémangezaumoinscinqfruitsetlégumesparjour). Partons donc du principe qu’on aie une copie d’un jeu Windows. Nous pouvons chercher le jeu, cliquer sur « Install », puis sur « Configure manually ». La première chose qu’il va falloir faire est de sélectionner le « runner ». C’est l’application qui va nous permettre de lancer notre jeu. Nous avons donc:  
* Linux (Runs game natiely): si on veut ajouter un jeu Linux manuellement, ou une application comme un émulateur qui ne serait pas dans la liste des runners supportés. Dans ce cas-là, dans la deuxième page (Game Options), sélectionner l’exécutable et les arguments.
* Steam: c’est plus simple d’importer son jeu, mais les utilisateurs avancés peuvent tenter des choses.
* Wine (Runs Windows games): si on veut exécuter un jeu Windows (.exe). Plusieurs choses seront à configurer. Dans « Game Options », sélectionner l’exécutable dans « Executable ». On peut ajouter un prefixe (un dossier de données) à chaque jeu manuellement, sinon le préfixe par défaut sera utilisé. Pour cela, il suffit de créer un dossier vide quelque part sur son PC et le sélectionner comme préfixe. Je préfère faire un préfixe manuel pour chaque jeu, de façon à bien séparer mes fichiers. Ne pas oublier de sélectionner la « Prefix Architecture » en 64bits. Dans « Runner Options », il faudra sélectionner la version de Wine qui va exécuter le jeu. Par défaut laissez la version de Lutris, mais si en exécutant un jeu vous avez un problème, il faudra considérer changer de runner. Le site [ProtonDB](https://www.protondb.com/) recense une immense liste de jeu ainsi que les avis et explications de la communauté. Ainsi, vous pourrez voir quelle version de Wine fonctionne le mieux avec quel jeu.  
![pdb1](/gamingonlinux/14.png)  
![pdb2](/gamingonlinux/15.png)  
Si ce n’est pas activé, activez « Enable DXVK/VKD3D » qui permet de convertil les appels DirectX (API graphique propriétaire à Microsoft) en appels Vulkan (API graphique nouvelle et cross-plateforme).


# Epic is Legendary
Epic Games a confirmé qu’ils ne développeraient jamais de client sur Linux. C’est bien triste, mais comment donc jouer aux jeux gratuits qu’ils offrent sur ma machine aux couleurs du pingouin ?  
Il existe deux solutions pour l’instant. La première consiste à installer EGS dans Lutris avec Proton. C’est une solution plutôt efficace, mais pour lancer un jeu EGS, nous serons obligés d’ouvrir le launcher avec Lutris.  
La deuxième solution qui existe est [Legendary](https://github.com/derrod/legendary). La manière la plus simple de l’installer est d’utiliser pip:  
`pip install legendary-gl`  
Une fois installé, il faudra s’authentifier:  
`legendary auth`  
Puis pour installer un jeu il faudra lister les jeux sur notre compte:  
`legendary list-games`  
Puis en copiant le nom listé suite à « App Name »:  
`legendart install AppName /path/to/game/folder/name`  
Pour lancer le jeu:  
`legendary launch AppName`  
Ainsi, nous pourrons ajouter des jeux Epic dans Lutris:  
Runner|Linux
Executable|legendary
Arguments|launch AppName

![legendary1](/gamingonlinux/16.png)
![legendary2](/gamingonlinux/17.png)


# Fixes and Workarounds
Certains jeux demanderont une configuration un peu plus avancée. Cette section est vouée à être agrandie dans le futur.

## Media Foundation Workaround
Certains jeux auront du mal à afficher certains médias vidéo. Le fix est de télécharger [le repo git mf](https://github.com/z0z0z/mf-installcab), de le placer à un endroit dans votre ordinateur où il ne bougera pas, et de run la commande suivante:  
`WINEPREFIX=/path/to/game/prefix /path/to/mf/folder/install-mf.sh`


## Easy Anti-Cheat
EAC ne fonctionne pas encore complètement sur Linux, bien que sur [leur site](https://www.easy.ac/en-us/support/game/guides/os/), ils annoncent qu’il est compatible avec Ubuntu 18.04. Il faudra donc mettre de côté Apex Legends et CoD Warzone.

## Battle Eye
Battle Eye ne fonctionne pas non plus sur Linux, donc il faudra oublier PUBG, Fortnite et autres pour l’instant. Mais une espoir de [Battle Eye compatible avec Proton](https://www.gamingonlinux.com/articles/battleye-now-say-theyre-working-with-valve-to-support-steam-play.14111) persiste.
