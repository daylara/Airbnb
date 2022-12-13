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
    conn.query("SELECT * FROM adverts INNER JOIN media on adverts.id=media.advert_id",(err,rows)=>{
        if(!err){
            rows.forEach(RowDataPacket => {
                allAdverts.push({
                    id: RowDataPacket.id,
                    price_per_day: RowDataPacket.price_per_day,
                    description: RowDataPacket.description,
                    address: RowDataPacket.address,
                    image_url: RowDataPacket.image_url,
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
    const ilanID = req.params.id;
    conn.query(
      `SELECT * FROM adverts INNER JOIN house ON adverts.house_id = house.id INNER JOIN media ON adverts.id = media.advert_id WHERE adverts.id = ${ilanID}`,
      (err, rows) => {
    
        if (!err) {
          res.render("advert", {
            price_per_day: rows[0].price_per_day,
            description: rows[0].description,
            address: rows[0].address,
            image1: rows[0].image_url,
            image2: rows[1].image_url,
            image3: rows[2].image_url,
            image4: rows[3].image_url,
            image5: rows[4].image_url,
            city_id: rows[0].city_id,
            total_bedrooms: rows[0].total_bedrooms,
            total_bathrooms: rows[0].total_bathrooms,
            num_guests: rows[0].num_guests,
            has_tv: rows[0].has_tv,
            has_kitchen: rows[0].has_kitchen,
            has_air_con: rows[0].has_air_con,
            has_heating: rows[0].has_heating,
            has_internet: rows[0].has_internet,
          });
          console.log(rows);
        } else console.log(err);
      }
    );
    });
app.get("/evsahibi", (req, res) => {
    res.render("evsahibi")
    });

app.listen(process.env.PORT, () => console.log("app is running"));
