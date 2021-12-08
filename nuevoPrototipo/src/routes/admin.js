const { request, response, query } = require('express');
const express = require('express');
const router = express.Router();

const pool = require('../database');


router.get('/add', (req,res) => {
    res.render('admin/hora');
});

router.post('/add', async (req,res) => {
    const {disponibilidad, fecha_hora, rut_p} = req.body;
    const newLink = {
        disponibilidad,
        fecha_hora,
        rut_p
    };
 //console.log('INSERT INTO hora_medica set ?', [newLink])   
    await pool.query('INSERT INTO hora_medica set ?', [newLink]);
    res.send('recivido');
});

router.get('/', async (req,res) => {
    const links = pool.query('SELECT * FROM hora_medica');
    res.render('admin/listashoras', {links: links})
});

module.exports = router;