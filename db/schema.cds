namespace asset.management;

entity Employees {
  key ID : Integer;
  name   : String;
  email  : String;
  department : String;
}

entity Assets {
  key ID : Integer;
  name   : String;
  type   : String;
  serialNumber : String;
  status : String;
  employee : Association to Employees;
}