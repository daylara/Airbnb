require("dotenv").config();
const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const session = require('express-session');
const ejs = require("ejs");

const conn = require("./dbService");
const { response } = require("express");
const app = express();

app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true 
}));

const multer = require('multer');
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/images/');
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  }
});
const upload = multer({ storage: storage });

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use("/public",express.static("public"));
app.set("view engine", "ejs");




app.get("/", async (req, res) => {
    const allAdverts = []
    conn.query("SELECT * FROM adverts INNER JOIN media ON adverts.id=media.advert_id",(err,rows)=>{
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

app.get("/adverts/:houseType", async (req,res) => {
    const houseType = req.params.houseType;
    const advertsByType = [];
    conn.query(`SELECT adverts.*, GROUP_CONCAT(media.image_url) AS images
    FROM adverts
    JOIN house ON adverts.house_id = house.id
    JOIN media ON adverts.id = media.advert_id
    WHERE house.house_type = ?
    GROUP BY adverts.id`, [houseType], (err, rows) => {
      if(!err) {
        rows.forEach(RowDataPacket => {
          advertsByType.push({
            id: RowDataPacket.id,
            price_per_day: RowDataPacket.price_per_day,
            description: RowDataPacket.description,
            address: RowDataPacket.address,
            images: RowDataPacket.images.split(',')
          });
        });
        res.json( { adverts: advertsByType });   
      }
      else {
        console.log(err);
      }
    });
  });
  


app.post('/register', (req, res) => {
    const { name, password, email } = req.body;
    if (!name || !password || !email) {
        res.json({ success: false, message: 'All fields are required.' });
    }
    else {
        conn.query('INSERT IGNORE INTO users (name, password, email) VALUES (?, ?, ?)', [name, password, email], (error, results) => {
            if (error) {
                throw error;
            }
            else if (results.affectedRows === 0){
                res.json({ success: false, message: 'User with this email already exists.' });
            }
            else {
                res.json({ success: true });
            }
        });
    }
});


app.post("/login", (req,res) => {
    const {email, password} = req.body;
    conn.query("SELECT * FROM users WHERE email = ? AND password = ?" , [email,password] , (err, result) => {
        if(err) throw (err);
        if(result.length > 0){
            req.session.user = result[0];
            res.send({ success: true });
        }
        else{
            res.json({ success: false, message: 'Invalid email or password.' });
        }
    });
});

app.get('/logout', function(req, res) {
  if (!req.session.user) {
    res.send({ success: false, message: 'You must be logged in to log out.' });
    return;
  }
  req.session.destroy(function(error) {
    if (error) {
      res.send({ success: false, message: 'There was an error during the logout process.' });
      return;
    }
    res.send({ success: true, message: 'You have been successfully logged out.' });
    
  });
});

app.listen(process.env.PORT, () => console.log("app is running"));
