<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TonyTechStore</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css" />
    <link href="https://use.fontawesome.com/releases/v5.0.1/css/all.css" rel="stylesheet">
   
   <style>

/* inmporter les fons */
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

/* en tous */
img{
    width: 100%;
    display: block;
}
.container{
    width: 88vw;
    margin: 0 auto;
}
.lg-title,
.md-title,
.sm-title{
    font-family: 'Roboto', sans-serif;
    padding: 0.6rem 0;
    text-transform: capitalize;
}
.lg-title{
    font-size: 2.5rem;
    font-weight: 500;
    text-align: center;
    padding: 1.3rem 0;
    opacity: 0.9;
}
.md-title{
    font-size: 2rem;
    font-family: 'Roboto', sans-serif;
}
.sm-title{
    font-weight: 300;
    font-size: 1rem;
    text-transform: uppercase;
}
.text-light{
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.5;
    opacity: 0.5;
    margin: 0.4rem 0;
}

/* Les Articles */
.products{
    background: var(--alice-blue);
    padding: 3.2rem 0;
}
.products .text-light{
    text-align: center;
    width: 70%;
    margin: 0.9rem auto;
}
.product{
    margin: 2rem;
    position: relative;
}
.product-content{
    background: var(--gray);
    padding: 3rem 0.5rem 2rem 0.5rem;
    cursor: pointer;
}
.product-img{
    background: var(--white-light);
    box-shadow: 0 0 20px 10px var(--white-light);
    width: 200px;
    height: 200px;
    margin: 0 auto;
    border-radius: 50%;
  
}

.product-btns{
    display: flex;
    justify-content: center;
    margin-top: 1.4rem;
    justify-content: space-between;

}
.btn-cart{
    border: 1px solid black;
    padding: 0.8rem 0;
    width: 125px;
    font-family: inherit;
    text-transform: uppercase;
    cursor: pointer;
    border: none;
    transition: all 0.6s ease;

}

.btn-cart{
    background: black;
    color: white;
    justify-content: space-between;
}

.btn-cart:hover{
    background: var(--carribean-green);
}

.product-info{
    background: white;
    padding: 2rem;
}
.product-info-top{
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.product-name{
    color: black;
    display: block;
    text-decoration: none;
    font-size: 1rem;
    text-transform: uppercase;
    font-weight: bold;
}
.product-price{
    padding-top: 0.6rem;
    padding-right: 0.6rem;
    display: inline-block;
}



/* Réponsive */
@media screen and (min-width: 992px){
    .product-items{
        display: grid;
        grid-template-columns: repeat(2, 1fr);
    }
    .product-col-r-bottom{
        display: grid;
        grid-template-columns: repeat(2, 1fr);
    }
}
@media screen and (min-width: 1200px){
    .product-items{
        grid-template-columns: repeat(3, 1fr);
    }
    .product{
        margin-right: 1rem;
        margin-left: 1rem;
    }
    .products .text-light{
        width: 50%;
    }
}

@media screen and (min-width: 1336px){
    .product-items{
        grid-template-columns: repeat(4, 1fr);
    }
    .product-collection-wrapper{
        display: grid;
        grid-template-columns: repeat(2, 1fr);
    }
    .flex{
        height: 60vh;
    }
    .product-col-left{
        height: 121.5vh;
    }
}


.containerform {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.containerform .content {
    text-align: center;
}

.containerform .content h3 {
    font-size: 30px;
    color: #333;
}
   </style>

</head>

<body>
    <header>

        <?php 
        require('entent.html') 
        ?>
        
    </header>


    <section>


    <div class = "products">

            <div class = "container">

                <h1 class = "lg-title">Bienvenu Chez TonyTechSTORE </h1>
                <p class = "text-light">Soyez le premier à en apprendre davantage sur les événements spéciaux, promotions, nouveautés et plus </p>
                <div class = "product-items">


            

                    <!-- Fire TV Stick  -->
                    

                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                                <img src = "images/des_articles/firestick.jpg" alt = "error">
                            </div>

                            <div class = "product-btns">

                                
                    
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Divers</h2>
                                <h3 class = "sm-title"> id_article : 1</h3>
                                <div class = "rating">
                                     <span><i class = "fas fa-plus"></i></span>
                                </div>
                            </div>
                            <h6 class = "product-name">Fire TV Stick avec télécommande vocale avec boutons de contrôle de la TV</h6>
                            <p class = "product-price">24,99€</p>
                           
                        </div>

                        <div class = "off-info">
                            <h2 class = "sm-title"></h2>
                        </div>
                    </div>
                    
                    <!-- Fire TV Stick  -->

                    <!-- Microsoft Surface Laptop Go -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                            <img src = "images/des_articles/MicrosoftSurfaceLaptopGo.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                                
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Informatique</h2>
                                <h3 class = "sm-title"> id_article : 2</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                                </div>
                            </div>
                            <h6 class = "product-name">Microsoft Surface Laptop Go  </h6>
                            <p class = "product-price">799€</p>
                        </div>
                    </div>
                    <!-- Microsoft Surface Laptop Go -->


                    <!-- Caixun EC43S1A 4K UHD Smart TV -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                            <img src = "images/des_articles/CaixunEC43S1A .jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                               
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Vidéo</h2>
                                <h3 class = "sm-title"> id_article : 3</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                                
                                </div>
                            </div>
                            <h6 class = "product-name">Caixun EC43S1A 4K UHD Smart TV</h6>
                            <p class = "product-price">299€</p>
                            
                        </div>
                    </div>
                    <!-- Caixun EC43S1A 4K UHD Smart TV -->

                    <!-- Asus Zenbook Flip UX363JA-EM120T -->

                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                            <img src = "images/des_articles/AsusZenbookFlip.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                                
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Informatique</h2>
                                <h3 class = "sm-title"> id_article : 4</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                                </div>
                            </div>
                            <h6 class = "product-name">Asus Zenbook Flip UX363JA-EM120T PC Portable 13.3" (Intel Core i5-1035G4, RAM 8Go, SSD 512Go, Windows 10) Clavier AZERTY Français</h6>
                            <p class = "product-price">819€</p>
                            
                        </div>
                    </div>
                    <!-- Asus Zenbook Flip UX363JA-EM120T  -->
                    
                    <!-- NIKON D780 appareil photo -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                                <img src = "images/des_articles/Nikon.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                    
                               
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Photo</h2>
                                <h3 class = "sm-title"> id_article : 5</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>

                                </div>
                            </div>
                            <h6  class = "product-name">NIKON D780 appareil photo Reflex plein format 24.5Mpx </h6>
                            <p class = "product-price">1299€</p>
                          
                        </div>
                    </div>
                    <!-- NIKON D780 appareil photo -->

                    <!-- sSamsung Galaxy SM-A525F  -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                                <img src = "images/des_articles/samsung.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                               
                               
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Téléphonie</h2>
                                <h3 class = "sm-title"> id_article : 6</h3>

                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                        
                                </div>
                            </div>
                            <h6 class = "product-name">Samsung Galaxy SM-A525F 16,5 cm (6.5) Double SIM Android 11 4G USB Type-C 6 Go 128 Go 4500 mAh Blanc </h6>
                            <p class = "product-price">288€</p>
                            
                        </div>
                    </div>
                    <!-- Samsung Galaxy SM-A525F -->

                    <!-- Apple iPhone 12 256 Go -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                            <img src = "images/des_articles/apple.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                              
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Téléphonie</h2>
                                <h3 class = "sm-title"> id_article : 7</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                                
                                </div>
                            </div>
                            <h6 class = "product-name">Apple iPhone 12 (256 Go) - Blanc (Comprend EarPods)</h6>
                            <p class = "product-price">929€</p>
                            
                        </div>
                    </div>
                    <!-- Apple iPhone 12 256 Go -->


                    <!--  Apple iMac Écran Retina 5K -->
                    <div class = "product">
                        <div class = "product-content">
                            <div class = "product-img">
                            <img src = "images/des_articles/imac.jpg" alt = "error">
                            </div>
                            <div class = "product-btns">
                                
                               
                            </div>
                        </div>

                        <div class = "product-info">
                            <div class = "product-info-top">
                                <h2 class = "sm-title">Informatique</h2>
                                <h3 class = "sm-title"> id_article : 8</h3>
                                <div class = "rating">
                                <span><i class = "fas fa-plus"></i></span>
                                
                                </div>
                            </div>
                            <h6 class = "product-name">Apple iMac Écran Retina 5K (27 Pouces, 8 Go RAM, 256 Go SSD Stockage)</h6>

                            <p class = "product-price">1799€</p>
                            
                        </div>
     
                    </div>
                    <!-- Apple iMac Écran Retina 5K -->
                </div>
            </div>

            <div>
     
    </section>


<section>

<div class="containerform">


<div class="content">

    
    <br>
    <form action="panier.php" method="post">



        <fieldset>

            <table>

                <tbody>
                    <br>

                    <tr>
                        <td align="right"> id_article: </td>
                        <td> <input name="id_article" placeholder="id_article" type="number" /> <br/></td>
                    </tr>

                    <tr>
                        <td align="right" id="decal"> Designation: </td>
                        <td> <input name="designation" placeholder="designation" /> <br/></td>
                    </tr>


                    <tr>
                        <td align="right "> Prix: </td>
                        <td> <input name="prix" placeholder="prix" /> <br/></td>
                    </tr>

                    <tr>
                        <td align="right ">Catégorie:</td>
                        <td> <select name="categorie" size="1 ">
                                <option value="vidéo ">Vidéo</option>
                                <option value="photo ">Photo</option>
                                <option value="informatique ">Informatique</option>
                                <option value="téléphonie ">Téléphonie</option>
                                <option value="divers ">Divers</option>
                                </select>

                        </td>

                    </tr>

                    <br>

                    <input type="submit" name="envoi" value="Ajouter" class = "btn-cart" >
                    <input type="submit" name="envoi" value="Voir Mon panier" class = "btn-cart" >
                    <input type="submit" name="envoi" value="Supprimer" class = "btn-cart">

                    <button type= "submit"></button>

                </tbody>
            </table>
        </fieldset>

           
        </div>


</section>



<footer>
<?php  require('pied.html') ?>
</footer>


</body>

</html>