---
title: Office sur Linux
author: Mickael A.
date: 2021-03-24 02:24:00 +0100
categories: [Tutorial, Intermédiaire, French]
tags: [linux, office]
---

Niveau: Intermédiaire  
Comment installer la suite Office sur son système Linux.  
![office](/officesurlinux/office.png)

# Introduction
Durant l’intégralité de ce guide, j’utiliserai mon propre ordinateur portable. Ce dernier est sous Pop!_OS 20.10. Je pars du principe que vous savez vous servir de Linux et de son terminal.

# Prérequis

## Téléchargement d'Office
Nous allons installer la suite office en utilisant l'application PlayOnLinux. Pour la version d'Office, j'ai décidé d'installer la version 2016 car elle est très stable et que c'est celle que j'ai installé sur mes ordinateurs sous Windows. Grâce à mon école, je dispose d'un abonnement à Office Pro Plus, c'est donc la version que je vais télécharger.  
Pour télécharger un iso de Office, vous avez plusieurs choix: utilisez [le site microsoft](https://account.microsoft.com) pour télécharger la dernière version de l'installeur, ou utiliser un de [ces liens](https://community.msguides.com/d/90-office-2016-microsoft-official-download-link-windows-7-sp1-to-10). Je conseille la deuxième option.  
Téléchargez l'iso ou img, puis montez-le ou extrayez-le.

## Installation des paquets  
Nous allons installer Wine. Pour cela, vous pouvez suivre les instructions sur [le site de Wine](https://wiki.winehq.org/Download). Sinon, il suffit de taper les commandes suivantes:  
```bash
sudo dpkg --add-architecture i386  
sudo apt install wine-stable:i386  
```
Les paquets `smbclient` et `winbind` seront nécessaires. On les installe avec la commande suivante:  
```bash
sudo apt install smbclient winbind  
```

## Installation de PlayOnLinux
Enfin, nous allons installer PlayOnLinux (POL). Il s'agit d'une application qui permet de gérer facilement des préfixes et des versions Wine, d'y installer des applications et de créer rapidement des raccourcis. On peut se débarasser de POL, mais cela demandera un peu de réflexion. Des instructions sont disponibles sur [le site](https://www.playonlinux.com/en/download.html). Sinon, tapez les commandes suivantes:  
```bash
wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -  
wget http://deb.playonlinux.com/playonlinux_stretch.list -O /etc/apt/sources.list.d/playonlinux.list  
apt-get update  
apt-get install playonlinux  
```

# Configuration POL
Dans POL, nous allons installer une version récente de Wine, à savoir 6.3.    
Dans `Tools > Manage Wine versions`, dans l'onglet `Wine versions (x86)`, sélectionnez la version 6.3 et installez-la avec la flèche.  
![wineversion](/officesurlinux/wineversion.png)  
Nous pouvons fermer cette fenêtre. Dans la fenêtre principale de POL, cliquez sur `Configure`, puis sur `New`. Sélectionnez impérativement 32 bits. Sélectionnez ensuite la version de wine qu'on vient d'installer (6.3) et donnez un nom à votre configuration. Si Wine vous le demande, installez wine-mono.  
![32bits](/officesurlinux/32bits.png)  
Vous devriez être de retour sur la page de votre configuration. Sélectionnez l'onglet `Miscellaneous`, cliquez sur `Open a shell`. Dans le terminal ainsi ouvert, tapez `winetricks dotnet48` (si winetricks n'est pas installé: `sudo apt install winetricks`). Suivez les instructions de l'installateur puis fermez le terminal quand il a fini (il installe d'abort dotnet40 puis dotnet48).  
Sélectionnez l'onglet `Install components` et installez `msxml6` et `riched20`.  
Sélectionnez l'onglet `Wine` et cliquez sur `Configure Wine`.  
![winecfg1](/officesurlinux/winecfg1.png)  
Vérifiez que `Windows version` est bien sur `Windows 7`, puis dans l'onglet `Libraries`, configurez les deux librairies en `native then builtin`.  
![winecfg2](/officesurlinux/winecfg2.png)  
Appliquez puis fermez cette fenêtre. Dans la fenêtre de votre configuration, cliquez sur `Registry Editor`. Placez-vous dans `HKEY_CURRENT_USER/Software/Wine`. Cliquez sur `Edit > New > Key` et nommez-là `Direct2D`. Avec celle clé sélectionnez cliquez encore sur `Edit > New > DWORD value`, nommez-là `max_version_factory` et vérifiez que sa valeur est bien 0.  
![regedit1](/officesurlinux/regedit1.png)  
Fermez ensuite cette fenêtre.

# Installation d'Office
Dans la fenêtre de votre configuration, dans l'onglet `Miscellaneous`, cliquez sur `Run a .exe in this virtual drive`. Sélectionnez votre image disque montée ou le dossier dans lequel elle est extraite. Naviguez dans `Office` et sélectionnez `Setup32.exe`.  
Pour ma part, l'installeur n'affiche pas la barre de progression comme sur Windows. Je le laisse simplement tourner jusqu'à ce qu'il ait fini.  
![install1](/officesurlinux/install1.png)  
Il ne m'affiche pas non plus le bouton fermer sur l'écran suivant. Il suffit juste d'appuyer sur la touche Entrée pour le fermer. L'installation est maintenant terminée.  
![install2](/officesurlinux/install2.png)  
Toujours dans la fenêtre de votre configuration, dans l'onglet `Miscellaneous`, cliquez sur `Open virtual drive's directory`.  
Naviquez dans `drive_c/Program Files/Microsoft Shared/ClickToRun` et copiez `AppvIsvSubSystems32.dll`, `C2R32.dll` et `AppVIsvStreamingManager.dll` dans `drive_c/Program Files/Microsoft Office/root/Office16`.  
Copiez `AppvIsvSubSystems32.dll` dans `drive_c/Program Files/Microsoft Office/root/Client`.  
Fermez votre explorateur de fichiers et retournez dans l'onglet `Wine`. Cliquez sur `Registry Editor`. Placez-vous dans `HKEY_CURRENT_USER/Software/Microsoft/Office/16.0/Common/Identity`. Cliquez sur `Edit > New > DWORD value`, nommez-là `EnableADAL` et vérifiez que sa valeur est bien à 0. Fermez ensuite l'éditeur de registre.  

# Configurer les raccourcis
Toujours dans la fenêtre de votre configuration, dans l'onglet `General`, cliquez sur `Make a new shortcut from this virtual drive`.  
Wine va scanner tout le disque virtuel. Voici la liste des raccourcis que vous allez vouloir ajouter:  

| Executable | Nom |
|-------|-------|
| WINWORD.EXE | Microsoft Word 2016 |
| EXCEL.EXE | Microsoft Excel 2016 |
| POWERPNT.EXE | Microsoft PowerPoint 2016 |
| OUTLOOK.EXE | Microsoft Outlook 2016 |
| MSPUB.EXE | Microsoft Publisher 2016 |
| MSACCESS.EXE | Microsoft Access 2016 |

A noter que OneNote ne fonctionnera simplement pas.  
Les raccourcis seront générés sur le bureau. On peut les déplacer dans `~/.local/share/applications` pour y avoir accès depuis les menus d'applications.

# Monter en version de Wine
Toujours dans la fenêtre de votre configuration, dans l'onglet `General`, cliquez sur le + à `Wine version`. Installez une version de Wine plus récente. Au moment d'écrire ce guide, j'ai réussi à monter jusqu'à la version .
