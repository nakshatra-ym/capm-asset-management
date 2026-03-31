using {asset.management as db} from '../db/schema';

service EmployeeService {

  @readonly
  entity Employee   as projection on db.Employee;
  @readonly
  entity Asset      as projection on db.Asset 
  actions {
    action assign(employeeID : Integer);
    action unassign();
  };
  @readonly
  entity AssetType  as projection on db.AssetType;
  @readonly
  entity AssetModel as projection on db.AssetModel;
  @readonly
  entity Location   as projection on db.Location;
  @readonly
  entity Department as projection on db.Department;

  @readonly
  entity Stock       as projection on db.Stock;

  @readonly
  entity AssetHistory as projection on db.AssetAssignmentHistory;

  @readonly
  entity StockMovement as projection on db.StockMovement;
}


service AdminService {

  entity AssetType  as projection on db.AssetType;
  entity AssetModel as projection on db.AssetModel;
  entity Location   as projection on db.Location;
  entity Department as projection on db.Department;
  entity Vendor     as projection on db.Vendor;

}

