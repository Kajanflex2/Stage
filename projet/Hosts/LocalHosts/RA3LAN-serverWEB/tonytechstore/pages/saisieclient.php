
<?php 
//inclure le fichier connection_aux_serveur.php pour établir une connexion
@include '../tables/conection_aux serveur.php';


//récupére submit
if(isset($_POST['envoie'])){
    //on récupére envoie mail
    $username = $_POST['username'];
    //on récupére envoie code
    $code = $_POST['code'];

    // on vérifife ou mail et code égale à mail et mode de passse
    $selection="SELECT * FROM client WHERE nom='$username' && code='$code'";
    
   
    
    // on demade à sql notre précédent demande
    $resultat=mysqli_query($conn,$selection);

    //sil le résultat supérieur "existe" on redirige vers paiment.php
    if (mysqli_num_rows($resultat) > 0 ) {

        header('Location:paiment.php');
      
    }else {
        
        //sinon on créer un  variable erreur arry on affiche le message mot de passe incorrect.
        $error[] =  'Nom d\'utilisateur ou Mot de pass Incorrect 😢😭😭😢';
    
    }

    mysqli_close($conn);

    //' or 1 = 1 -- '
    //SELECT id_client,nom, prenom, adresse, ville, mail, code, age FROM Client WHERE nom = '' or 1 = 1 -- '' and code = '123';
};

?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link rel="stylesheet" href="../css/login_et_creer/logcreer.css">
</head>

<body>
    <header> <?php  include_once('entent.html') ?></header>

<div class="form-container">




   <form action="" method="post">
      <h3>Connexion</h3>
      <?php
      //récupéré le variable error et afffiche le message error.
      if(isset($error)){
         foreach($error as $error){
            echo '<span class="error-msg">'.$error.'</span>';
         };
      };
      ?>
     <input type="text" name="username" required placeholder="Nom d'utilisateur">
      <input type="password" name="code" required placeholder="Mot de Passe">
      <input type="submit" name="envoie" value="S'indentifier" class="button">
      <p>Vous n’avez pas encore de compte ? 😱 <a href="../tables/login_et_creer/creeruncompte.php"> Créez-en un !</a></p>
   </form>
</div>
<footer> <?php  include_once('pied.html') ?></footer>
</body>
</html>
