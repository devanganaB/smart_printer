const fs = require('fs');
const { print } = require('pdf-print');

const folderPath = 'C:/path/to/folder'; // Replace with the actual folder path
const printerName = 'Printer Name'; // Replace with the name of the printer

function printPDFsInFolder() {
  fs.readdir(folderPath, (err, files) => {
    if (err) {
      console.error('Error reading folder:', err);
      return;
    }

    if (files.length === 0) {
      console.log('No PDF files found in the folder');
      setTimeout(printPDFsInFolder, 5000); // Retry after 5 seconds
      return;
    }

    let printedCount = 0;

    files.forEach((file) => {
      const filePath = `${folderPath}/${file}`;

      if (file.endsWith('.pdf')) {
        print(filePath, {
          printer: printerName,
          options: {
            sides: 'two-sided-long-edge', // Set duplex printing option
          },
        })
          .then(() => {
            console.log(`File '${file}' printed successfully`);

            // Delete the printed file
            fs.unlink(filePath, (err) => {
              if (err) {
                console.error(`Error deleting file '${file}':`, err);
              } else {
                console.log(`File '${file}' deleted successfully`);
              }
            });

            printedCount++;

            if (printedCount === files.length) {
              console.log('All PDF files have been printed');
              setTimeout(printPDFsInFolder, 5000); // Retry after 5 seconds
            }
          })
          .catch((err) => {
            console.error(`Error printing file '${file}':`, err);
          });
      }
    });
  });
}

printPDFsInFolder();