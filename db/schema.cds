namespace asset.management;
using { managed } from '@sap/cds/common';


entity Department : managed {
  key ID : Integer;
  name : String;
  manager : Association to one Employee;
}

entity Employee : managed {
  key ID : Integer;
  name   : String;
  email  : String;
  department : Association to one Department ;
  assets : Association to many Asset on assets.employee  = $self;
}

entity AssetType : managed {
  key ID : Integer;
  name   : String;
  category   : String;
  maxPerEmployee : Integer;
  isConsumable : Boolean;

  models : Composition of many AssetModel on models.assetType = $self ;
  assets : Composition of many Asset on assets.assetType = $self;
}

entity AssetModel : managed {
  key ID : Integer;
  name : String;
  manufacturer : String;
  assetType : Association to one AssetType;
}

entity Asset : managed { 
  key ID : Integer;
  serialNumber : String;
  assetType : Association to one AssetType;
  model : Association to one AssetModel;

  status : String enum {
    Available = 'Available';
    Assigned = 'Assigned';
    Repair = 'Repair';
    Disposed = 'Disposed';
  };

  purchaseDate : DateTime;
  warrantyEnd : DateTime;

  employee : Association to one Employee ;
  history : Composition of many AssetAssignmentHistory on history.asset = $self;
}


entity AssetAssignmentHistory : managed {
  key ID : Integer;
  asset : Association to one Asset;
  employee : Association to one Employee;
  assignedAt : DateTime;
  returnedAt : DateTime;
  assignedBy : String;
}


entity Vendor : managed {
  key ID : Integer;
  name : String;
  contactPerson : String;
  email : String;
  phone : String;
}

entity Location : managed {
  key ID : Integer;
  building : String;
  floor : Integer;
  room : String;
  city : String;
}

entity Stock : managed {
  key ID : Integer;
  assetType : Association to one AssetType;
  location  : Association to one Location;
  quantityAvailable : Integer;
  minThreshold : Integer;     
}

entity StockMovement : managed {
  key ID : Integer;
  assetType : Association to one AssetType;   
  quantity : Integer;
  movementType : String enum {
    INBOUND = 'I';
    OUTBOUND = 'O';
  };     
  reference : String enum {
    ASSIGN = 'A';
    UNASSIGN = 'U';
    PURCHASE = 'P';
  };    
}