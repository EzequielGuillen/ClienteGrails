package com.mercadolibre.itacademy

import grails.converters.JSON
import groovy.json.JsonSlurper

class ClientController {

    def index() {
        def url = new URL( "http://localhost:8083/marcas")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        [sites:json.parse(connection.getInputStream())]

    }


    def categories(String idSite){
        def url = new URL("http://localhost:8083/marcas/"+idSite+"/articulos")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def resultado = [categories: json.parse(connection.getInputStream())]

        render resultado as JSON
    }


    def category(String idCategory){
        def url = new URL("http://localhost:8083/articulos/"+idCategory)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def resultado = [category: json.parse(connection.getInputStream())]

        render resultado as JSON
    }


    def deleteItem(String idItem){
        def url = new URL("http://localhost:8083/articulos/"+idItem)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("DELETE")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        connection.getInputStream()
    }

    def crearItem(String data){

        def url = new URL("http://localhost:8083/articulos");
        def conn = (HttpURLConnection) url.openConnection()
        conn.setDoOutput(true);
        conn.setDoInput(true);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestMethod("POST");
        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
        wr.write(data);
        wr.flush();
        StringBuilder sb = new StringBuilder();
        JsonSlurper json = new JsonSlurper()
        def items = json.parse(conn.getInputStream())
        render( items as JSON)
    }



}
