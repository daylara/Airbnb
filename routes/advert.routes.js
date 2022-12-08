module.exports = app => {
    const adverts = require("../controllers/advert.controller.js");
    var router = require("express").Router();
    router.post("/", adverts.create);
    router.get("/status", adverts.findAllStatus);

    app.use('/api/adverts', router);
};