const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const { Assets } = this.entities;

  this.on('assignAsset', async (req) => {

    const assetID = req.params[0].ID;
    const { employeeID } = req.data;

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

  this.before("CREATE","Assets",(req) => {
    if(!req.data.status){
      req.data.status = "Available";
    }
  })


});