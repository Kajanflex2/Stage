<?php 
        session_start();
        require('entent.html') 
?>






 <!DOCTYPE html>
 <html lang="en">
 <head>
     <meta charset="UTF-8">
     <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>luhn</title>
 </head>

 <style>
     @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700;900&display=swap');

:root{
    --white-light: rgba(255, 255, 255, 0.5);
    --alice-blue: #f8f9fa;
    --carribean-green: #40c9a2;
    --gray: #ededed;
}

*{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

body{
    font-family: 'Quicksand', sans-serif;
}

#hello{

        font-size: 50px;
         text-align: center;

         color:red;

        
}

 </style>
 <body>


 <p>

 <?php
           
function Luhn($numero,$longueur){ 
     // On passe à  la fonction la variable contenant le numéro à  vérifier
                                                
        // et la longueur qu'il doit impérativement avoir
            if ( strlen($numero) == $longueur)  {

            /* on décompose le numéro dans un tableau  */
            for ($i=0;$i<$longueur;$i++){
                 $tableauChiffresNumero[$i]=substr($numero,$i,1);
                 }
                 /* on parcours le tableau pour additionner les chiffres */
                 $luhn=0; // clef de luhn à Â  tester
                 for ($i=0;$i<$longueur;$i++){
                if ($i%2==0){ // si le rang est pair (0,2,4 etc.)
                        if(($tableauChiffresNumero[$i]*2) > 9){ 
            // On regarde si son double est > à?Â  9
                                                    $tableauChiffresNumero[$i]=(
            $tableauChiffresNumero[$i]*2)-9; //si oui on lui retire 9

                                                                                                            
            // et on remplace la valeur

                                                                                                            
            // par ce double corrigé
                                            }
                                            else{
                                                    $tableauChiffresNumero[$i]=
            $tableauChiffresNumero[$i]*2; // si non on remplace la valeur

                                                                                                    
            // par le double
                                            }
                                    }
                                    $luhn=$luhn+$tableauChiffresNumero[$i]; 
            // on additionne le chiffre à Â  la clef de luhn
                            }
                            /* test de la divition par 10 */
                            if($luhn%10==0){
                                    return true;
                            }
                            else{
                                    return false;
                            }
                    }
                    else{
                            return false; 
            // la valeur fournie n'est pas conforme (caractère non numérique ou mauvaise
            // longueur)
                    }
            }


            @include '../tables/conection_aux serveur.php';

            if (isset ($_POST['mode']) ) $mode = $_POST['mode'];
            if (isset ($_POST['numero']) )$numero=$_POST['numero'];
            
           // if (isset ($_POST['longueur']) )$longueur=$_POST['longueur'];

          

            if( isset($mode)  and $mode == "verifier"){

                    $longueur=16; 

                    if(Luhn($numero,$longueur)){

                        echo '<div id="hello"> Votre commande est bien enregistrer</div>';

                    }

                    else{
                            echo 
                    "<font color=\"#c00000\" face=\"helveticat, arial, sans-serif\">Le" .
                    " Erreur pas valide </font><br>";
                    }

                    echo "<form action=\" acceuil.php\" method=\"POST\">\n";
                    echo "\r\r<input type=\"submit\" value=\"Acceuil\">\n";
                    echo "</form>";
            }
                    else{

                    }
 ?>
 </p>

     
 </body>
 </html>