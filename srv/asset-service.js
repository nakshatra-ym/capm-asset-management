const cds = require('@sap/cds');
const { UPDATE, INSERT, SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(async function () {

  const { Asset, Employee, Stock, AssetHistory, StockMovement, AssetType } = this.entities;


  this.on('assign', 'Asset', async (req) => {

    const assetID = req.params[0].ID;
    const { employeeID } = req.data;

    const employee = await SELECT.one.from(Employee).where({ ID: employeeID });
    const asset = await SELECT.one.from(Asset).where({ ID: assetID });

    if (!employee) {
      return req.reject(404, `Employee ${employeeID} not found`, 'EMPLOYEE_NOT_FOUND');
    }

    if (!asset) {
      return req.reject(404, `Asset ${assetID} not found`, 'ASSET_NOT_FOUND');
    }

    const assetType = await SELECT.one.from(AssetType).where({ ID: asset.assetType_ID });

    if (!assetType) {
      return req.reject(404, 'Asset type not found', 'ASSET_TYPE_NOT_FOUND');
    }

    const { count } = await SELECT.one
      .from(Asset)
      .columns('count(1) as count')
      .where({
        employee_ID: employeeID,
        assetType_ID: asset.assetType_ID,
        status: 'Assigned'
      });

    const numberOfAssets = count ;
    const maxPerEmployee = assetType.maxPerEmployee;

    if (numberOfAssets >= maxPerEmployee && maxPerEmployee != null) {
      return req.reject(409, `Employee ${employeeID} already has ${numberOfAssets} assets assigned`, 'EMPLOYEE_ALREADY_HAS_ASSETS');
    }

    const stock = await SELECT.one.from(Stock).where({ assetType_ID: asset.assetType_ID });

    if (!stock) {
      return req.reject(404, 'Stock not found', 'STOCK_NOT_FOUND');
    }

    if (asset.status === 'Assigned') {
      return req.reject(409, `Asset ${assetID} is already assigned`, 'ASSET_ALREADY_ASSIGNED');
    }

    if (stock.quantityAvailable < 1) {
      return req.reject(409, `Asset ${assetID} is out of stock`, 'ASSET_OUT_OF_STOCK');
    }

    await UPDATE(Asset)
      .set({
        employee: {
          ID: employeeID
        },
        status: 'Assigned'
      })
      .where({ ID: assetID });

    await UPDATE(Stock)
      .set({
        quantityAvailable: stock.quantityAvailable - 1
      })
      .where({ assetType_ID: asset.assetType_ID });


    await INSERT.into(AssetHistory).entries({
      asset: {
        ID: assetID
      },
      employee: {
        ID: employeeID
      },
      assignedAt: new Date(),
      assignedBy: req.user.ID
    })

    await INSERT.into(StockMovement).entries({
      assetType: {
        ID: asset.assetType_ID
      },
      quantity: 1,
      movementType: 'O',
      reference: 'A'
    })


    return "Asset assigned successfully";

  });

  this.on('unassign', async (req) => {

    const assetID = req.params[0].ID;

    const asset = await SELECT.one.from(Asset).where({ ID: assetID });


    if (!asset) {
      return req.reject(404, `Asset ${assetID} not found`, 'ASSET_NOT_FOUND');
    }

    const stock = await SELECT.one.from(Stock).where({ assetType_ID: asset.assetType_ID });

    if (!stock) {
      return req.reject(404, 'Stock not found', 'STOCK_NOT_FOUND');
    }

    if (asset.status !== 'Assigned') {
      return req.reject(409, `Asset ${assetID} is already unassigned`, 'ASSET_ALREADY_UNASSIGNED');
    }

    await UPDATE(Asset).set({
      employee: null,
      status: 'Available'
    }).where({ ID: assetID });

    await UPDATE(Stock)
      .set({
        quantityAvailable: stock.quantityAvailable + 1
      })
      .where({ assetType_ID: asset.assetType_ID });

    await UPDATE(AssetHistory).set({
      returnedAt: new Date(),
    }).where({ asset_ID: assetID, returnedAt: null });

    await INSERT.into(StockMovement).entries({
      assetType: {
        ID: asset.assetType_ID
      },
      quantity: 1,
      movementType: 'I',
      reference: 'U'
    })

    return "Asset unassigned successfully";
  })

  this.before("CREATE", "Asset", (req) => {
    if (!req.data.status) {
      req.data.status = "Available";
    }
  })
});