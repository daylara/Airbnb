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
          //console.log(allAdverts);
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

app.listen(process.env.PORT, () => console.log("app is running"));
