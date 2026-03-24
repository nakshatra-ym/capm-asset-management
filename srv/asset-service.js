const cds = require('@sap/cds');
const { UPDATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(async function () {

  const { Assets, Employees } = this.entities;


  this.on('assignAsset', async (req) => {

    const employeeID = req.params[0].ID;
    const { assetID } = req.data;

    const asset = await SELECT.one.from(Assets).where({ ID: assetID });

    if (!asset) {
      req.error('Asset not found');
    }

    if (asset.status === 'Assigned') {
      req.error('Asset already assigned');
    }

    await UPDATE(Assets)
      .set({
        employee_ID: employeeID,
        status: 'Assigned'
      })
      .where({ ID: assetID });

    return "Asset assigned successfully";

  });

  this.on('unassignAsset', async (req) => {

    const assetID = req.params[0].ID;
    
    const asset = await SELECT.one.from(Assets).where({ ID: assetID });

    if (!asset) {
      req.error('Asset not found');
    }
    console.log("asset:");
    
    console.log(asset);
    
    if(!asset.employee_ID || asset.status == 'Available'){
      req.error('Asset is already unassigned')
    }

    await UPDATE(Assets).set({
      employee_ID : null,
      status : 'Available'
    }).where({ID : assetID});

    console.log("asset2:");
    
    console.log(asset);

    return "Asset unassigned successfully";
  })

    // this.before("CREATE","Assets",(req) => {
    //   if(!req.data.status){
    //     req.data.status = "Available";
    //   }
    // })
  });