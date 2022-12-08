const Advert = require("../models/advert.model.js");

exports.create = (req,res) => {
   
};

exports.findAllStatus = (req,res) => {
    Advert.getAllStatus((err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Some error occurred while retrieving adverts."
          });
        else res.send(data);
      });

};
