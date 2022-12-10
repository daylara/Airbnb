require("dotenv").config();
const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const ejs = require("ejs")

const conn = require("./dbService");
const { response } = require("express");
const app = express();


app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
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
    conn.query(`SELECT description,address FROM adverts ` )
    res.render("advert");
});
app.get("/evsahibi", (req, res) => {
    res.render("evsahibi")
});


app.post("/createUser" , async (req,res) => {
    const name = req.body.name;
    const password = req.body.password;
    const email = req.body.email;
    const phone_number =req.body.phone_number;

    const sqlSearch = "SELECT * FROM users WHERE name = ?";
    const search_query = mysql.format(sqlSearch,[name]);

    const sqlInsert = "INSERT INTO users (name , email, password , phone_number) VALUES (?,?,?,?)";
    const insert_query =mysql.format(sqlInsert,[name,email,password,phone_number]);

    conn.query(search_query , async(err,result) => {
        if(err) throw (err);
        console.log("------> Search Results");
        console.log(result.length);

        if(result.length !=0){
            console.log("------> User already exists");
            res.sendStatus(409) ;

        }
        else{
            conn.query(insert_query,(err,result)=> {
                if(err) throw (err);
                console.log(result.insertId);
                res.sendStatus(201);
            });
        };
    });

});

//require("./routes/advert.routes.js")(app);
app.listen(process.env.PORT, () => console.log("app is running"));
