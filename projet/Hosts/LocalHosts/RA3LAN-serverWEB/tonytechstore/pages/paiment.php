
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">


    <style>

        body {
        background-image: linear-gradient(-90deg, #E6E2AF 0%, #002F2F 100%);
        }

        .component {
        position: relative;
        width: 30%;
        margin: 5rem auto;
        padding: 1rem;

        box-shadow: 2px 2px 10px #454545;
        background-color: #FFFFFF;
        
        text-align: center;
        }

        .credit-card h2 {
        color: rgba(4,99,128,1);
        }

        .component .credit-card form {
        display:flex;
        flex-direction: column;
        }

        .component .credit-card .line {
        display: flex;
        }

        .component .credit-card .line input {
        width: 20%; /* on définit une taille plus petite qu'il le faut, le flex-grow fera le reste */
        flex: 1;
        margin: 0.4rem 0.3rem;
        }

        input {
                border: none;
                border-bottom: 1px solid rgba(0,0,0,.12);
                margin: 1rem 0;
                padding: 4px;
                font-size: 1rem;
                outline: none;
        }

        input::-webkit-input-placeholder {
                color: #AAAAAA;
        }

        .valid-button {
                border: 0;
                padding: 1rem 2rem;
                background-color: rgba(4,99,128,0.9);
                color: #EFECCA;
                font-weight:bold;
                margin-top:2rem;
        box-shadow: 1px 1px 1px black;
        }

        .valid-button:hover {
        background-color: rgba(4,99,128,1);
        box-shadow: none;
        }

        .total {
        position: absolute;
        top: 3em;
        left: -8em;
        z-index: -1;
        
        background: #002F2F;
        color: #A7A37E;
        
        width: 100px;
        transform: rotate(-35deg);
        display:flex;
        flex-wrap: wrap;
        justify-content:center;
        align-items:center;
        padding-right: 2rem;
        
        box-shadow: 1px 1px 5px black;
        }

        .total p {
        font-size: 1.5rem;
        }
    </style>
</head>


<body>

    <header>
        <?php  require('entent.html') ?>
    </header>




<section class="component">
  
  <div class="credit-card">

    <h2>Carte Blue </h2>
    
    <form action="luhn.php" method="POST">
            
      <div class="line">
              <input type="text" name="numero" size="16" maxlength="16" placeholder="CARD" />
        </div>
        <input type="hidden" name="mode" value="verifier">
      <input type="submit" class="valid-button" value="verifier"></input>
    </form>
  </div>
</section>


    <footer>
        <?php  include_once('pied.html') ?>
    </footer>

  
</body>
</html>




