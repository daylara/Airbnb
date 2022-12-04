require("dotenv").config();
const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const ejs = require("ejs")

const conn = require("./dbService");
const { response } = require("express");
const app = express();


app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));
app.set("view engine", "ejs");

app.get("/", (req, res) => {
    res.render("home.ejs");
    });
app.get("/evsahibi", (req, res) => {
    res.render("evsahibi.ejs")
    });

app.listen(process.env.PORT, () => console.log("app is running"));
