
// Deux lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour que le script se comporte comme une console (pas de point virgule => affichage du résultat) 
// Charge les fonctions du TP
exec("bataille_fonctions.sci", -1);
// Déclaration des variables
x = [];
y = [];
gagnant = 0;
temps = 0;
nbparties = 0;

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

// Menu
printf('=== CHOIX DU MODE ===\n');
printf("0 - quitter \n")
printf("1 - mode normal\n")
printf("2 - mode test\n")
printf("3 - mode stats\n")
choixmode = input('Choisir avec le numéro associé ');
if choixmode == 0 then
    halt()
end
while choixmode ~= 1 && choixmode ~= 2 && choixmode ~= 3
    printf('=== CHOIX DU MODE ===\n');
    printf("0 - quitter\n")
    printf("1 - mode normal\n")
    printf("2 - mode test\n")
    printf("3 - mode stats\n")
    choixmode = input('Choisir avec le numéro associé ');
end

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MODE NORMAL //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

printf("Vous avez choisi le mode numéro %d \n",choixmode);
if choixmode == 1 then
    printf('=== MODE NORMAL ===\n');
    printf('===================\n');
    [x,y]=distribue();
    printf("Jeu1 \n");
    afficherjeu(x);
    printf("Jeu2 \n");
    afficherjeu(y);
    [gagnant,temps]=bataille(x,y);
    printf("Le joueur %d gagne en %d tours !!! ", gagnant, temps);
end

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// MODE TEST ///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

if choixmode == 2 then
    printf('=== MODE TEST ===\n');
    printf('=================\n');
    printf('1 - Nombre différent de cartes aux joueurs\n');
    printf('2 - Ne pas distribuer toutes les cartes\n');
    choixsousmode = input('Choisir avec le numéro associé ');
    while choixsousmode ~= 1 && choixsousmode ~= 2
        printf('=== MODE TEST ===\n');
        printf('=================\n');
        printf('1 - Nombre différent de cartes aux joueurs\n');
        printf('2 - Ne pas distribuer toutes les cartes\n');
        choixsousmode = input('Choisir avec le numéro associé ');
    end
    if choixsousmode == 1 then
        choixnbcartes = input('Combien de cartes pour joueur 1 ? ');
        while int(choixnbcartes) > 55 || int(choixnbcartes) < 1
            printf('Choisir un nombre entre 1 et 55 ');
            choixnbcartes = input('Combien de cartes pour joueur 1 ? ');
        end
        nb1 = int(choixnbcartes);
        nb2 = 56 - nb1;
        //printf("%d %d",nb1,nb2);
        [x,y]=distribuepaslesmemes(nb1,nb2);
        printf("Jeu1 \n");
        afficherjeu(x);
        printf("Jeu2 \n");
        afficherjeu(y);
        [gagnant,temps]=bataille(x,y);
        printf("Le joueur %d gagne en %d tours !!! ", gagnant, temps);
        //printf("Le joueur %d gagne en %d tours !!! ", gagnant, temps);
    end
//////////////////////////////// PAS TTE LES CARTES ////////////////////////////
    if choixsousmode == 2 then
        paquet = [];
        nbtt = 0;
        for i = 1:13
            printf('Voules-vous les %d ? 1 = oui | 0 = non ', i+1);
            resultat = input('');
            while resultat ~= 1 && resultat ~= 0
                printf('Voules-vous les %d ? 1 = oui | 0 = non ', i+1);
                resultat = input('');
            end
            if resultat == 1 then
                for j = 1:4
                    paquet(1,$+1) = i;
                    nbtt=nbtt+1;
                end     
            end
        end
        [x,y]=distribuepastout(paquet,nbtt/2);
        printf("Jeu1 \n");
        afficherjeu(x);
        printf("Jeu2 \n");
        afficherjeu(y);
        [gagnant,temps]=bataille(x,y);
        printf("Le joueur %d gagne en %d tours !!! ", gagnant, temps);
    end
end

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// MODE STATS //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

if choixmode == 3 then
    printf('=== MODE STATS ===\n');
    printf('==================\n');
    printf('1 - Stats sur la durée moyenne\n');
    printf('2 - Stats sur une forme de force\n');
    printf('3 - Stats sur linfluence de la remise\n'); 
    
    choixsousmode = input('Choisir avec le numéro associé ');
    while choixsousmode ~= 1 && choixsousmode ~= 2 && choixsousmode ~= 3
        printf('1 - Stats sur la durée moyenne\n');
        printf('2 - Stats sur une forme de force\n');
        printf('3 - Stats sur linfluence de la remise\n');
        choixsousmode = input('Choisir avec le numéro associé ');
    end    
    
    printf('==================\n');

    Etude_Stats(choixsousmode);
    
    
end


























