using { asset.management as db } from '../db/schema';

service AssetService {

   @UI.LineItem: [
    { Value: name },
    { Value: email },
    { Value: department }
  ]
  entity Employees as projection on db.Employees;

   @UI.LineItem: [
    { Value: name },
    { Value: type },
    { Value: status },
    { Value: employee_ID }
  ]
  entity Assets as projection on db.Assets
  actions {
      action assignAsset(employeeID : UUID);
  };

}