const Task = require("../models/task.js");
module.exports = {
    show: (req, res) => {
        Task.find({})
        .then( tasks => {
            res.json(tasks);
        })
        .catch( error => {
            console.log("Get All Error: ", error);
            res.json(error);
        });
    },

    show_one: (req, res) => {
        Task.findOne({ _id: req.params.id })
        .then( task => res.json(task))
        .catch( error => res.json(error));
    },

    add: (req, res) => {
        Task.create(req.body)
        .then( task =>res.json(task))
        .catch( error => res.json(error));
    },
    update: (req, res) =>{
      Task.update({_id:req.params.id})
        .then(task => res.json(task))
        .catch(err => res.json(err));
    },
    remove: (req, res) => {
        Task.deleteOne({ _id:req.params.id })
        .then( task => res.json(task))
        .catch( error => {
            console.log("Remove One Error: ", error);
            res.json(error);
        });
    },

}