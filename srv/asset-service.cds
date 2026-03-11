using { asset.management as db } from '../db/schema';

service AssetService {

  entity Employees as projection on db.Employees;

  entity Assets as projection on db.Assets
  actions {
      action assignAsset(employeeID : UUID);
  };

}