<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel=“stylesheet” href=“https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css“>
    <script src=“https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js”></script>
    <script src=“https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js”></script>


    <style>

        .flex{
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;
        }

        .table{
            border: 1px solid black;
            width: 300px;
            padding: 15px;
            margin: 15px;
            display: inline-block;

        }



    </style>

</head>
<body>
<div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">Crear Articulo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="form" class="modal-body mx-3">

                <div class="md-form mb-5">
                    <select name="idmarca" class="form-control" id="selectnav" >
                        <g:each in="${sites}" var="site">
                            <option value="${site?.id}" >${site?.name}</option>
                        </g:each>
                    </select>
                </div>

                <div class="md-form mb-5">
                    <i class="fas fa-envelope prefix grey-text"></i>
                    <input type="text" name="name" id="defaultForm-nombre" class="form-control validate">
                    <label data-error="wrong" data-success="right" for="defaultForm-nombre">Nombre del articulo</label>
                </div>

                <div class="md-form mb-4">
                    <i class="fas fa-lock prefix grey-text"></i>
                    <input type="text" name="picture" id="defaultForm-picture" class="form-control validate">
                    <label data-error="wrong" data-success="right" for="defaultForm-picture">Picture</label>
                </div>

                <div class="md-form mb-4">
                    <i class="fas fa-lock prefix grey-text"></i>
                    <input type="number" name="total" id="defaultForm-total" class="form-control validate">
                    <label data-error="wrong" data-success="right" for="defaultForm-total">Total de items</label>
                </div>

            </form>
            <div class="modal-footer d-flex justify-content-center">
                <button onclick="tabla.crearItem()" type="submit" class="btn btn-default" data-dismiss="modal" >Crear</button>
            </div>
        </div>
    </div>
</div>



<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="/client">Navbar</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active" style="place-self: self-end" >
                <a href="" class="nav-link" data-toggle="modal" onclick="tabla.showForm()">Launch
                    Modal Login Form<span class="sr-only">(current)</span></a>
            </li>
        </ul>
    </div>
</nav>

<select onchange="tabla.fetchData()" id="select" >
    <g:each in="${sites}" var="site">
        <option value="${site?.id}" >${site?.name}</option>
    </g:each>
</select>


    <div class="flex" id="tabla">



        <table class="table" border="1">
            <thead>
            <tr>
                <td >Nombre de la Categoria</td>
            </tr>
            </thead>
            <tr v-for="category in categories">
                <td >
                    <a href="#" @click="fetchCategory(category.id)">{{category.name}}</a>
                </td>
            </tr>
        </table>
        <div v-for="children in cantSubCat">
            <table class="table" border="1">
                <tr v-for="category in children">
                    <td >
                        <a href="#" @click="fetchCategory(category.id)">{{category.name}}</a>
                    </td>
                </tr>
            </table>
        </div>

        <div id="modal"></div>


        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalBody">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="tabla.deleteItem()" class="btn btn-danger" data-dismiss="modal">Borrar</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        %{--
        <table border="1">
            <tr v-for="cat in subCategories">
                <td >
                    {{cat.name}}
                </td>
            </tr>
        </table>
--}%

    </div>




<script>

    var tabla = new Vue({

        el:'#tabla',

        data: {
            categories:[],
            cantSubCat: [],
            id: 0,
            info: ""
        },

        methods: {
            fetchData: function () {
                document.getElementById("modal").innerHTML="";
                document.getElementById("modal").className="";
                var idSite = document.getElementById("select").value


                axios.get('/client/categories', {
                    params: {
                        idSite: idSite
                    }
                }).then(function (response) {
                    tabla.cantSubCat=[]
                    tabla.categories = response.data.categories;
                }).catch(function (error) {
                    console.log(error)
                })

            },
            fetchCategory: function (idCategory) {

                document.getElementById("modal").innerHTML="";
                document.getElementById("modal").className="";

                for(var i = 0; i< tabla.categories.length;i++){
                    if(tabla.categories[i].id==idCategory){
                        tabla.cantSubCat=[]
                    }
                }
                for(var i = 0;i<tabla.cantSubCat.length-1; i++){
                    for(var j =0;j<tabla.cantSubCat[i].length;j++){
                        if(tabla.cantSubCat[i][j].id==idCategory){
                            tabla.cantSubCat=tabla.cantSubCat.slice(0,i+1);
                            break;
                        }
                    }
                }
                axios.get('/client/category', {
                    params: {
                        idCategory: idCategory
                    }
                }).then(function (response) {
                    if(response.data.category.children_categories.length==0){

                        var categoryInfo = response.data.category
                        tabla.id=categoryInfo.id
                        tabla.info=categoryInfo
                        if(categoryInfo.picture==null){

                            document.getElementById("exampleModalLabel").innerText = categoryInfo.name;
                            document.getElementById("modalBody").innerHTML="<h1>ID:</h1><p>" + categoryInfo.id + "</p>" +
                                '<asset:image src="33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png"/>'+
                                "<h1>Total Items in this category:</h1><p>" + categoryInfo.total_items_in_this_category + "</p>";
                            $('#myModal').modal("show");
                            //document.getElementById("modal").className="table"
                        } else {
                            document.getElementById("exampleModalLabel").innerText = categoryInfo.name;
                            document.getElementById("modalBody").innerHTML = "<h1>ID:</h1><p>" + categoryInfo.id + "</p>" +
                                "<img src='" + categoryInfo.picture + "' > " +
                                "<h1>Total Items in this category:</h1><p>" + categoryInfo.total_items_in_this_category + "</p>";
                            $('#myModal').modal("show");
                        }

                    } else {
                        tabla.cantSubCat.push(response.data.category.children_categories)
                    }
                }).catch(function (error) {
                    console.log(error)
                })

            },
            
            deleteItem: function () {
                axios.delete('/client/deleteItem',{
                    params:{
                        idItem: tabla.id
                    }
                }).then(function (response) {
                    tabla.fetchData()
                }).catch( function (error) {
                    console.log(error)
                })
            },
            
            crearItem: function () {
                var data = new FormData(document.querySelector('form'))

                var objeto = {
                    "marca": parseInt(data.get("idmarca")),
                    "name": data.get("name"),
                    "picture": data.get("picture"),
                    "total_items_in_this_category": parseInt(data.get("total"))
                };

                window.data= data

                console.log(objeto)
                axios.get('/client/crearItem',{
                    params:{
                        data: objeto

                    }
                }).then(function (response) {
                    tabla.fetchData();

                }).catch(function (error) {
                    console.log(error)
                })
            },

            showForm: function () {
                $('#modalLoginForm').modal("show");
            }

        },
        created: function () {

            this.fetchData()

        }
    })

</script>


</body>
</html>