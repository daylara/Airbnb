const sql = require("../dbService.js");

const Advert = function(advert){
    this.price_per_day = advert.price_per_day;
    this.description = advert.description;
    this.address = advert.address;
    this.status = advert.status;

};

Advert.create = (newAdvert,result) => {
    sql.query("INSERT INTO adverts SET ?" , newAdvert , (err,res) => {
        if(err){
            console.log("error: " , err);
            result(err,null);
            return;
        }

        console.log("created advert: ", { id: res.insertId , ...newAdvert});
        result(null, { id: res.insertId , ...newAdvert });
    });
};

Advert.getAllStatus = result => {
    sql.query("SELECT * FROM adverts WHERE status=false", (err,res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
          }
      
        console.log("adverts: ", res);
        result(null, res);

    });
};



module.exports = Advert;