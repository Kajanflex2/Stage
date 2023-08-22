
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css" />
    <link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
</head>


<style>

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


/* General button style */
.btn {
  border: none;
  font-family: 'Lato';
  font-size: inherit;
  background: none;
  cursor: pointer;
  display: inline-block;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-weight: 700;
  outline: none;
  position: relative;
  
  transition: all 0.3s;
}

.btn:after {
  content: '';
  position: absolute;
  z-index: -1;
  -webkit-transition: all 0.3s;
  -moz-transition: all 0.3s;
  transition: all 0.3s;
}

/* Pseudo elements for icons */
.btn:before {
  font-family: 'FontAwesome';
  speak: none;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;
  position: relative;
  -webkit-font-smoothing: antialiased;
}


/* Icon separator */
.btn-sep {
  padding: 25px 60px 25px 120px;
}

.btn-sep:before {
  background: rgba(0,0,0,0.15);
}


/* Button 2 */
.btn-2 {
  background: #2e6ccc;
  color: #fff;
}

.btn-2:hover {
  background: #27ae60;
}

.btn-2:active {
  background: #27ae60;
  top: 2px;
}

.btn-2:before {
  position: absolute;
  height: 100%;
  left: 0;
  top: 0;
  line-height: 3;
  font-size: 140%;
  width: 60px;
}


/* Icons */

.icon-cart:before {
  content: "\f07a";
}




</style>
<body>
    
<head>

<?php  require('entent.html') ?>


</head>

    <h2>
    <?php

    
    session_start();

    //Ajouter
    if($_POST["envoi"]=="Ajouter" && $_POST["id_article"]!="" && $_POST["designation"]!="" && $_POST["prix"]!="") {

        $code=$_POST['id_article'];
        $article=$_POST['designation'];
        $prix=$_POST['prix'];

    // A completer : récupération des saisies du visiteur


        $_SESSION['id_article']=$_SESSION['id_article']."//".$code;
        $_SESSION['designation']=$_SESSION['designation']."//".$article;
        $_SESSION['prix']=$_SESSION['prix']."//".$prix;
    }

    //Voir Mon panier

    if($_POST["envoi"] == "Voir Mon panier")
    {
        echo " <table border=\"1\"> ";
        echo " <tr> <td colspan=\"3\"> <b> Récapitulatif de votre commande </b> </td>";
        echo " <tr> <th> &nbsp;code&nbsp; </th> <th> &nbsp;article&nbsp; </th> <th> &nbsp; prix&nbsp; </th> ";

        $prixtotal=0;
        $tab_code=explode("//",$_SESSION['id_article']);
        $tab_article=explode("//",$_SESSION['designation']);
        $tab_prix=explode("//",$_SESSION['prix']);


        //affichage du panier. Le résultat attendu est illustré sur la figure 3

        for ($i=1;$i<count($tab_code);$i++)
        {

            echo "<tr><td>" . $tab_code[$i] . "</td><td>" . $tab_article[$i] . "</td><td>" .sprintf("%01.2f", $tab_prix[$i])."</td></tr>"; //A completer pour constituer le panier
            $prixtotal = $prixtotal + $tab_prix[$i] ; // A completer (calculer le prix total)

        }

        echo "<tr><td colspan=2> PRIX TOTAL</td> <td>".sprintf("%01.2f",$prixtotal)."</td>";
        echo"</table>";
    }

    if($_POST["envoi"]==["Supprimer"]){
    session_unset();
    session_destroy();
    echo "<h3>La session est terminée </h3>";
}

?>

<br>
<a href="saisieclient.php" target="_blank" class="btn btn-2 btn-sep icon-cart"> Paiment</a>



<html>
</html>