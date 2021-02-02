//fonction de distribution normal
function [jeu1, jeu2] = distribue()
    //déclaration des variables
    paquetdecarte = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13];
    jeu1 = 1:26;
    jeu2 = 1:26;
    k=1
    i=1
    //distribution cartes jeu1
    //Tant que le joueur 1 n'a pas 26 cartes dans son paquet (26 car on part de k=1)
    while k ~=27
        //tirage au sort d'un nombre entre 1 et 52
        res = grand(1,1,"uin",1,52);
        //si la carte numéro res(tiré au sort au dessus) est présente dans paquetdecarte (valeur différente de 0) alors
        if paquetdecarte(1, res) ~= 0 then
            //on ajoute la carte au jeu1
            jeu1(1,k) = paquetdecarte(1, res);
            //on supprime ensuite la carte (on met sa valeur à 0) dans le paquetdecarte
            paquetdecarte(1, res) = 0;
            //on définie qu'on a ajouté une carte au jeu1
            k= k+1;
        end
    end
    j = 1;
    //distribution cartes jeu2, même principe que pour le jeu1
    while j ~=27
        res = grand(1,1,"uin",1,52);
        if paquetdecarte(1, res) ~= 0 then
            jeu2(1,j) = paquetdecarte(1, res);
            paquetdecarte(1, res) = 0;
            j = j + 1;
        end
    end
endfunction
//fonction de distribution alternative -> pas toutes les cartes
//même principe que la première fonction de distribution (détaillé)
function [jeu1, jeu2] = distribuepastout(paquetdecarte, nbcartes)
    jeu1 = 1:nbcartes;
    jeu2 = 1:nbcartes;    
    k=1
    i=1
    z = nbcartes+1;
    u = nbcartes * 2;      
    while k ~= z
        res = grand(1,1,"uin",1,u);
        if paquetdecarte(1, res) ~= 0 then
            jeu1(1,k) = paquetdecarte(1, res);
            paquetdecarte(1, res) = 0;
            k= k+1;
        end
    end
    j = 1;
    while j ~= z
        res = grand(1,1,"uin",1,u);
        if paquetdecarte(1, res) ~= 0 then
            jeu2(1,j) = paquetdecarte(1, res);
            paquetdecarte(1, res) = 0;
            j = j + 1;
        end
    end
endfunction
//fonction de distribution alternative -> pas le même nombre de cartes
function [jeu1, jeu2] = distribuepaslesmemes(nbcartes1, nbcartes2)
    jeu1 = [];
    jeu2 = [];
    recup = [];
    nbcartesenplus = 0;
    //distribution des cartes aux 2 joueurs (26 de chaque coté)
    [jeu1,jeu2]=distribue();
    //cas ou le joueur 1 a plus de cartes
    if nbcartes1 > nbcartes2 then
        //on calcul le nombre de carte en plus à donner au joueur1
        nbcartesenplus = 26 - nbcartes2;
        //on transforme ce nombre en entier pour éviter un problème de variable
        nbcartesenplus = int(nbcartesenplus);
        //pour le nombre de carte à donner en plus au joueur 1
        for i = 1:nbcartesenplus
            //on définie une matrice qui prent la 1ère carte du joueur2
            recup(1) = int(jeu2(1));
            //on la donne au joueur 1 (en fin de son paquet)
            jeu1(1,$+1) = recup(1);
            //on supprime la 1ère carte du joueur 2 qui vient d'être donné au joueur1
            jeu2(1) = [];
        end          
    end
    //cas ou le joueur 2 a plus de cartes ==> Même idée que pour le cas au dessus
    if nbcartes1 < nbcartes2 then
        nbcartesenplus = 26 - nbcartes1;
        nbcartesenplus = int(nbcartesenplus);
        for i = 1:nbcartesenplus
            recup(1) = int(jeu1(1));
            jeu2(1,$+1) = recup(1);
            jeu1(1) = [];            
        end  
    end   
endfunction
//fonction de la bataille
function [gagnant,temps]= bataille(jeu1,jeu2)
    temps =0;
    gagnant = 0;
    Bataille=[];
    B=[];
    //tant qu'il n'y a pas de gagnant
    while(jeu1 ~=[] && jeu2 ~= [])
    //si le joueur1 gagne la manche
        if(jeu1(1)>jeu2(1))then
            //ajout des cartes dans le jeu1
            jeu1=[jeu1,jeu1(1),jeu2(1)];
            TailleM=size(jeu1);
            //suppression des premières cartes dans les 2 paquets
            jeu1=suppJeu(jeu1,TailleM(1,2));
            TailleM=size(jeu2);
            jeu2=suppJeu(jeu2,TailleM(1,2));
            //incrémentation du nombre de tours
            temps = temps +1;    
        else
            //si le joueur2 gagne la manche
            //ajout des cartes dans le jeu2
            jeu2=[jeu2,jeu2(1),jeu1(1)];
            //suppression des premières cartes dans les 2 paquets
            TailleM=size(jeu1);
            jeu1=suppJeu(jeu1,TailleM(1,2));
            TailleM=size(jeu2);
            jeu2=suppJeu(jeu2,TailleM(1,2));
            //incrémentation du nombre de tours
            temps = temps +1;  
        end;
        //cas où les cartes sont les mêmes
        if(jeu1(1)==jeu2(1))
            //vérification si gagnant
            while(jeu1(1)==jeu2(1))
                if(jeu1 == [] || jeu2==[])
                    then
                    if(jeu1 == [])
                    then gagnant = 1;
                    return;
                    else gagnant = 2;
                    return;
                    end;
                end;
                //mise à jour de Bataill et des deux jeux
                Bataille=[Bataille,jeu1(1),jeu2(1)]
                TailleM=size(jeu1);
                jeu1=suppJeu(jeu1,TailleM(1,2));
                TailleM=size(jeu2);
                jeu2=suppJeu(jeu2,TailleM(1,2));
                //vérification si gagnant
                if(jeu1 == [] || jeu2==[])
                    then
                    if(jeu1 == [])
                    then gagnant = 1;
                    return;
                    else gagnant = 2;
                    return;
                    end;
                end;
                //mise à jour de Bataill et des deux jeux (2ème carte)
                Bataille=[Bataille,jeu1(1),jeu2(1)]
                TailleM=size(jeu1);
                jeu1=suppJeu(jeu1,TailleM(1,2));
                TailleM=size(jeu2);
                jeu2=suppJeu(jeu2,TailleM(1,2));
                //vérification si gagnant
                if(jeu1 == [] || jeu2==[])
                    then
                    if(jeu1 == [])
                    then gagnant = 1;
                    return;
                    else gagnant = 2;
                    return;
                    end;
                end;
            end;
            //vérification de qui gagne
            if(jeu1(1)>jeu2(1))then
                 jeu1=[jeu1,Bataille,jeu1(1),jeu2(1)];
                TailleM=size(jeu1);
                jeu1=suppJeu(jeu1,TailleM(1,2));
                TailleM=size(jeu2);
                jeu2=suppJeu(jeu2,TailleM(1,2));
                temps = temps +1;
            else
                jeu2=[jeu2,Bataille,jeu2(1),jeu1(1)];
                TailleM=size(jeu1);
                jeu1=suppJeu(jeu1,TailleM(1,2));
                TailleM=size(jeu2);
                jeu2=suppJeu(jeu2,TailleM(1,2));
                temps = temps +1;
            end;
            Bataille=[];
        end;
    end;
 //vérification si gagnant
 if(jeu1 == [])
     then gagnant = 2;
    else gagnant = 1;
 end;
 
endfunction
//fonction de bataille alternative -> inverse ordre de remise
//même principe que la première fonction de bataille (détaillé)
function [gagnant,temps]=bataillegalanterie(jeu1,jeu2)
    temps =0;
    gagnant = 0;
    Bataille=[];
    B=[];
    while(jeu1 ~=[] && jeu2 ~= [])
    if(jeu1(1)>jeu2(1))
        then jeu1=[jeu1,jeu2(1),jeu1(1)];
        TailleM=size(jeu1);
        jeu1=suppJeu(jeu1,TailleM(1,2));
        TailleM=size(jeu2);
        jeu2=suppJeu(jeu2,TailleM(1,2));
        temps = temps +1;    
    else
        jeu2=[jeu2,jeu1(1),jeu2(1)];
        TailleM=size(jeu1);
        jeu1=suppJeu(jeu1,TailleM(1,2));
        TailleM=size(jeu2);
        jeu2=suppJeu(jeu2,TailleM(1,2));
        temps = temps +1;  
    end;
    if(jeu1(1)==jeu2(1))
        while(jeu1(1)==jeu2(1))
            if(jeu1 == [] || jeu2==[])
                then
                if(jeu1 == [])
                then gagnant = 1;
                return;
                else gagnant = 2;
                return;
                end;
            end;
            Bataille=[Bataille,jeu2(1),jeu1(1)]
            TailleM=size(jeu1);
            jeu1=suppJeu(jeu1,TailleM(1,2));
            TailleM=size(jeu2);
            jeu2=suppJeu(jeu2,TailleM(1,2));
            if(jeu1 == [] || jeu2==[])
                then
                if(jeu1 == [])
                then gagnant = 1;
                return;
                else gagnant = 2;
                return;
                end;
            end;
            Bataille=[Bataille,jeu2(1),jeu1(1)]
            TailleM=size(jeu1);
            jeu1=suppJeu(jeu1,TailleM(1,2));
            TailleM=size(jeu2);
            jeu2=suppJeu(jeu2,TailleM(1,2));
            if(jeu1 == [] || jeu2==[])
                then
                if(jeu1 == [])
                then gagnant = 1;
                return;
                else gagnant = 2;
                return;
                end;
            end;
        end;
        if(jeu1(1)>jeu2(1))
        then jeu1=[jeu1,Bataille,jeu2(1),jeu1(1)];
        TailleM=size(jeu1);
        jeu1=suppJeu(jeu1,TailleM(1,2));
        TailleM=size(jeu2);
        jeu2=suppJeu(jeu2,TailleM(1,2));
        temps = temps +1;
    else
        jeu2=[jeu2,Bataille,jeu1(1),jeu2(1)];
        TailleM=size(jeu1);
        jeu1=suppJeu(jeu1,TailleM(1,2));
        TailleM=size(jeu2);
        jeu2=suppJeu(jeu2,TailleM(1,2));
        temps = temps +1;
    end;
    Bataille=[];
    end;
 end;
 
 if(jeu1 == [])
     then gagnant = 2;
    else gagnant = 1;
 end;
 
endfunction

function L=suppJeu(A,taille)
    L=[];
    t=taille-1
    for i= 1:t
        L=[L,A(i+1)];
    end
endfunction

function afficherjeu(jeucartes)
    for i = 1:length(jeucartes)
        printf("%d ", jeucartes(i));
    end
    printf("\n");
endfunction
//Fonction d'étude de proba et stats
function Etude_Stats(choixEtude)
    nbparties = 100;
    jeu1 = [];
    jeu2 = [];
    j1gg = 0;
    j2gg = 0;
    moyenne = 0;
    //étude de la durée moyenne d'une partie + gagnant, etc
    if choixEtude == 1 then
        //simulation de 100 parties normales
        printf("Simulation sur 100 parties\n");
        printf("===== Partie normales =====\n");
        for i = 1:100
            //distribution
            [jeu1,jeu2]=distribue();
            //bataille
            [gagnant,temps]=bataille(jeu1,jeu2);
            //compter combien de victoirede chaque cotés
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            //mise à jours de la moyenne
            moyenne = moyenne + temps;        
        end
        //calcul de la moyenne
        moyenne = moyenne/100;
        //affichages caractèristiques
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        printf("Une partie dure en moyenne %d tours\n",moyenne);
        
        
        printf("\n===== Partie test =====\n");
        printf("=> Pas le même nombre de carte \n Joueur 1 : 20 cartes \n Joueur 2 : 36 cartes\n");
        jeu1 = [];
        jeu2 = [];
        j1gg = 0;
        j2gg = 0;
        moyenne = 0;
         //simulation de 100 parties où le joueur 2 à plus de carte
        for i = 1:100
            //distribution
            [jeu1,jeu2]=distribuepaslesmemes(20,36);
            //bataille
            [gagnant,temps]=bataille(jeu1,jeu2);
            //maj gagnant
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            //maj moyenne
            moyenne = moyenne + temps;        
        end
        //calcul de la moyenne
        moyenne = moyenne / 100;
        //affichages caractèristiques
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        printf("Une partie dure en moyenne %d tours\n",moyenne);

        //simulation de 100 parties où le joueur 2 à beaucoup plus de carte
        printf("\n=> Pas le même nombre de carte \n Joueur 1 : 10 cartes \n Joueur 2 : 46 cartes\n");
        jeu1 = [];
        jeu2 = [];
        j1gg = 0;
        j2gg = 0;
        moyenne = 0;
        for i = 1:100
            [jeu1,jeu2]=distribuepaslesmemes(10,46);
            [gagnant,temps]=bataille(jeu1,jeu2);
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            moyenne = moyenne + temps;        
        end
        moyenne = moyenne / 100;
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        printf("Une partie dure en moyenne %d tours\n",moyenne);
        
        //simulation de 100 parties où l'on joue qu'avec les 2,3 et 4
        printf("\n=> Seulement avec les cartes 2 à 4\n");
        paquet = [1 1 1 1 2 2 2 2 3 3 3 3];
        jeu1 = [];
        jeu2 = [];
        j1gg = 0;
        j2gg = 0;
        moyenne = 0;
        for i = 1:100
            [jeu1,jeu2]=distribuepastout(paquet,6);
            [gagnant,temps]=bataille(jeu1,jeu2);
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            moyenne = moyenne + temps;        
        end
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        moyenne = moyenne / 100;
        printf("Une partie dure en moyenne %d tours\n",moyenne);
        //simulation de 100 parties où l'on joue qu'avec les cartes 2 à 9
        printf("\n=> Seulement avec les cartes 2 à 9\n");
        paquet = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8];
        jeu1 = [];
        jeu2 = [];
        j1gg = 0;
        j2gg = 0;
        moyenne = 0;
        for i = 1:100
            [jeu1,jeu2]=distribuepastout(paquet,16);
            [gagnant,temps]=bataille(jeu1,jeu2);
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            moyenne = moyenne + temps;        
        end
        moyenne = moyenne / 100;
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        printf("Une partie dure en moyenne %d tours\n",moyenne);
        //simulation de 100 parties où l'on joue qu'avec les 10,11,12 et 13
        printf("\n=> Seulement avec les plus fortes valeurs : 10 à 13\n");
        paquet = [10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13];
        jeu1 = [];
        jeu2 = [];
        j1gg = 0;
        j2gg = 0;
        moyenne = 0;
        for i = 1:100
            [jeu1,jeu2]=distribuepastout(paquet,8);
            [gagnant,temps]=bataille(jeu1,jeu2);
            if gagnant == 1 then
                j1gg = j1gg+1;
            else 
                j2gg = j2gg+1;            
            end
            moyenne = moyenne + temps;        
        end
        moyenne = moyenne / 100;
        printf("Le joueur 1 a gagné : %d parties\n",j1gg);
        printf("Le joueur 2 a gagné : %d parties\n",j2gg);
        printf("Une partie dure en moyenne %d tours\n",moyenne);
        
        
    end
    
    //étude d'une potentiel force
    if choixEtude == 2 then
        jeu1 = [];
        jeu2 = [];
        win1 = 0;
        win2 = 0;
        quiwin = [];
        suppwin = 0;
        gagnant = 0;
        temps = 0;
        gagne = "";
        //exemple en affichant 2 jeu de carte
        [jeu1,jeu2]=distribue();
        printf("Jeu1 \n");
        afficherjeu(jeu1);
        printf("Jeu2 \n");
        afficherjeu(jeu2);
        //affiche le gagnant de chaque premières manches
        for i = 1:26            
            if jeu1(i) > jeu2(i)then
                quiwin(1,i) = 1;
                win1 = win1+1;
            end
            if jeu1(i) < jeu2(i)then
                quiwin(1,i) = 2;
                win2 = win2+1;
            end
            if jeu1(i) == jeu2(i)then
                quiwin(1,i) = 0;
            end
        end
        //affichage caractèristique de qui gagne combien de premières manches
        printf("\nEn comptant les premières manches nous obtenons : \n")
        afficherjeu(quiwin);
        printf("%d manches gagné par le joueur 1\n",win1);
        printf("%d manches gagné par le joueur 2\n",win2);
        
        if win1 > win2 then
            suppwin = 1;
        else 
            suppwin = 2;
        end
        
        [gagnant,temps]=bataille(jeu1,jeu2);
        
        if suppwin == gagnant then
            gagne = "Gagné";
        else
            gagne = "Perdu";
        end
        //fin de l'exemple et début de la simulation
        printf("Nous pouvons supposer que le joueur %d va gagner\n",suppwin);
        printf("Dans ce cas, cest le joueur %d qui gagne. Cest donc %s \n",gagnant, gagne);
        printf("\nSimulation sur 100 parties :\n")
        gagne = 0;
        //lancement de 100 parties
        for i = 1:100
            jeu1 = [];
            jeu2 = [];
            win1 = 0;
            win2 = 0;
            suppwin = 0;
            gagnant = 0;
            temps = 0;
            //distribution
            [jeu1,jeu2]=distribue();
            for i = 1:26            
                if jeu1(i) > jeu2(i)then
                    win1 = win1+1;
                end
                if jeu1(i) < jeu2(i)then
                    win2 = win2+1;
                end
            end
            //suposition gagnant
            if win1 > win2 then
                suppwin = 1;
            else 
                suppwin = 2;
            end
            
            [gagnant,temps]=bataille(jeu1,jeu2);
            //compter le nombre de fois où les suppositions sont bonnes
            if suppwin == gagnant then
                gagne = gagne +1;
            end            
        end 
        printf("Nous avons déviné le gagnant de %d parties sur 100 parties !", gagne);
    end
    
    //etude de la remise dans le paquet
    if choixEtude == 3 then
        gagnantp1 = 0;
        gagnantp2 = 0;
        tmps1 = 0;
        tmps2 = 0;
        nbdiff = 0;
        moy1 = 0;
        moy2 = 0;
        for i = 1:100
            jeu1 = [];
            jeu2 = [];
            gagnantp1 = 0;
            gagnantp2 = 0;
            tmps1 = 0;
            tmps2 = 0;
            [jeu1,jeu2]=distribue();
            [gagnantp1,tmps1]=bataille(jeu1,jeu2);
            [gagnantp2,tmps2]=bataillegalanterie(jeu1,jeu2);
            if gagnantp1 ~= gagnantp2 then
                nbdiff = nbdiff + 1;
            end
            moy1 = moy1 + tmps1;
            moy2 = moy2 + tmps2;
            
        end
        moy1 = moy1/100;
        moy2 = moy2/100;
        printf("Le changement de remise a influencé %d parties\n",nbdiff);
        printf("Moyenne 1 : %d \nMoyenne 2 : %d\n",moy1, moy2);
        
    end
endfunction
