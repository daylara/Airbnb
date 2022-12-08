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

app.get("/", async (req, res) => {
    const allAdverts = []
    conn.query("SELECT id,price_per_day,description,address FROM adverts",(err,rows)=>{
        if(!err){
            // console.log(rows)

          rows.forEach(RowDataPacket => {
               allAdverts.push({
                id:RowDataPacket.id,
                 price_per_day: RowDataPacket.price_per_day,
                 description: RowDataPacket.description,
                 address: RowDataPacket.address
               });
          });  
          console.log(allAdverts);
          res.render("home",{adverts:allAdverts});
        }
        else
        console.log(err);
    })
    });
app.get("/ilan/:id", (req, res) => {
    conn.query(`SELECT description,address FROM adverts ` )
    res.render("advert");
    });
app.get("/evsahibi", (req, res) => {
    res.render("evsahibi")
    });

app.listen(process.env.PORT, () => console.log("app is running"));
