const express = require('express');
const fileUpload = require('express-fileupload');
const pdfjsLib = require('pdfjs-dist');
const fs = require('fs');
const pdf = require('pdf-page-counter');


const app = express();
const port = 3000;
var i = 1;

app.use(fileUpload());
 app.get('/',(req,res)=>{
    res.send("home");
    
 })
app.post('/upload', (req, res) => {
  if (req.files && req.files.pdf) {
    // const file = req.files;
    const pdfFile = req.files.pdf;
    const filePath = 'C:/Users/sadha/OneDrive/Desktop/empty/' + pdfFile.name; // Replace 'FOLDER_PATH' with the folder path on the PC
    i++;
    pdfFile.mv(filePath, (err) => {
      if (err) {
        console.error('Error saving PDF file:', err);
        res.sendStatus(500);
      } else {
        console.log('PDF file saved successfully:', filePath);
        let dataBuffer = fs.readFileSync(filePath);
        pdf(dataBuffer).then(function(data) {
 
          // number of pages
          console.log(data.numpages);
          res.send({pages:data.numpages,statusCode:200})
       
        });
      }
    });
  } else {
    res.send({statusCode : 400});
  }
});


app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});